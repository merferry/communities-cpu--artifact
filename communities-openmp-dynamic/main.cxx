#include <cstdint>
#include <cstdio>
#include <utility>
#include <random>
#include <vector>
#include <string>
#include <iostream>
#include <algorithm>
#include "inc/main.hxx"

using namespace std;




#pragma region CONFIGURATION
#ifndef TYPE
/** Type of edge weights. */
#define TYPE float
#endif
#ifndef MAX_THREADS
/** Maximum number of threads to use. */
#define MAX_THREADS 64
#endif
#ifndef REPEAT_BATCH
/** Number of times to repeat each batch. */
#define REPEAT_BATCH 5
#endif
#ifndef REPEAT_METHOD
/** Number of times to repeat each method. */
#define REPEAT_METHOD 5
#endif
#pragma endregion




#pragma region METHODS
#pragma region HELPERS
/**
 * Obtain the modularity of community structure on a graph.
 * @param x original graph
 * @param a rak result
 * @param M sum of edge weights
 * @returns modularity
 */
template <class G, class R>
inline double getModularity(const G& x, const R& a, double M) {
  auto fc = [&](auto u) { return a.membership[u]; };
  return modularityBy(x, fc, M, 1.0);
}
#pragma endregion




#pragma region EXPERIMENTAL SETUP
/**
 * Run a function on each batch update, with a specified range of batch sizes.
 * @param x original graph
 * @param rnd random number generator
 * @param fn function to run on each batch update
 */
template <class G, class R, class F>
inline void runBatches(const G& x, R& rnd, F fn) {
  using  E = typename G::edge_value_type;
  double d = BATCH_DELETIONS_BEGIN;
  double i = BATCH_INSERTIONS_BEGIN;
  for (int epoch=0;; ++epoch) {
    for (int r=0; r<REPEAT_BATCH; ++r) {
      auto y  = duplicate(x);
      for (int sequence=0; sequence<BATCH_LENGTH; ++sequence) {
        auto deletions  = generateEdgeDeletions (rnd, y, size_t(d * x.size()/2), 1, x.span()-1, true);
        auto insertions = generateEdgeInsertions(rnd, y, size_t(i * x.size()/2), 1, x.span()-1, true, E(1));
        tidyBatchUpdateU(deletions, insertions, y);
        applyBatchUpdateOmpU(y, deletions, insertions);
        fn(y, d, deletions, i, insertions, sequence, epoch);
      }
    }
    if (d>=BATCH_DELETIONS_END && i>=BATCH_INSERTIONS_END) break;
    d BATCH_DELETIONS_STEP;
    i BATCH_INSERTIONS_STEP;
    d = min(d, double(BATCH_DELETIONS_END));
    i = min(i, double(BATCH_INSERTIONS_END));
  }
}


/**
 * Run a function on each number of threads, for a specific epoch.
 * @param epoch epoch number
 * @param fn function to run on each number of threads
 */
template <class F>
inline void runThreadsWithBatch(int epoch, F fn) {
  int t = NUM_THREADS_BEGIN;
  for (int l=0; l<epoch && t<=NUM_THREADS_END; ++l)
    t NUM_THREADS_STEP;
  omp_set_num_threads(t);
  fn(t);
  omp_set_num_threads(MAX_THREADS);
}


/**
 * Run a function on each number of threads, with a specified range of thread counts.
 * @param fn function to run on each number of threads
 */
template <class F>
inline void runThreadsAll(F fn) {
  for (int t=NUM_THREADS_BEGIN; t<=NUM_THREADS_END; t NUM_THREADS_STEP) {
    omp_set_num_threads(t);
    fn(t);
    omp_set_num_threads(MAX_THREADS);
  }
}


/**
 * Run a function on each number of threads, with a specified range of thread counts or for a specific epoch (depending on NUM_THREADS_MODE).
 * @param epoch epoch number
 * @param fn function to run on each number of threads
 */
template <class F>
inline void runThreads(int epoch, F fn) {
  if (NUM_THREADS_MODE=="with-batch") runThreadsWithBatch(epoch, fn);
  else runThreadsAll(fn);
}
#pragma endregion




#pragma region PERFORM EXPERIMENT
/**
 * Perform the experiment.
 * @param x original graph
 */
template <class G>
void runExperiment(const G& x) {
  using K = typename G::key_type;
  using V = typename G::edge_value_type;
  random_device dev;
  default_random_engine rnd(dev());
  int repeat  = REPEAT_METHOD;
  int retries = 5;
  double M = edgeWeightOmp(x)/2;
  // Follow a specific result logging format, which can be easily parsed later.
  auto glog = [&](const auto& ans, const char *technique, int numThreads, const auto& y, auto M, auto deletionsf, auto insertionsf) {
    printf(
      "{-%.3e/+%.3e batchf, %03d threads} -> "
      "{%09.1fms, %09.1fms mark, %09.1fms init, %.3e aff, %04d iters, %01.9f modularity} %s\n",
      double(deletionsf), double(insertionsf), numThreads,
      ans.time, ans.markingTime, ans.initializationTime,
      double(ans.affectedVertices), ans.iterations, getModularity(y, ans, M), technique
    );
  };
  // Get community memberships on original graph (static).
  auto b0 = louvainStaticOmp(x);
  glog(b0, "louvainStaticOmpOriginal", MAX_THREADS, x, M, 0.0, 0.0);
  auto f0 = rakStaticOmp(x);
  glog(f0, "rakStaticOmpOriginal", MAX_THREADS, x, M, 0.0, 0.0);
  #if BATCH_LENGTH>1
  vector<K> B2, F2, F3;
  vector<W> VW, CW;
  #else
  const auto& B2 = b0.membership;
  const auto& F2 = f0.membership;
  const auto& F3 = b0.membership;
  const auto& VW = b0.vertexWeight;
  const auto& CW = b0.communityWeight;
  #endif
  // Get community memberships on updated graph (dynamic).
  runBatches(x, rnd, [&](const auto& y, auto deletionsf, const auto& deletions, auto insertionsf, const auto& insertions, int sequence, int epoch) {
    double M = edgeWeightOmp(y)/2;
    #if BATCH_LENGTH>1
    if (sequence==0) {
      B2 = b0.membership;
      F2 = f0.membership;
      F3 = b0.membership;
      VW = b0.vertexWeight;
      CW = b0.communityWeight;
    }
    #endif
    // Adjust number of threads.
    runThreads(epoch, [&](int numThreads) {
      auto flog = [&](const auto& ans, const char *technique) {
        glog(ans, technique, numThreads, y, M, deletionsf, insertionsf);
      };
      // Find static Louvain.
      auto b1 = louvainStaticOmp(y, {repeat});
      flog(b1, "louvainStaticOmp");
      // Find frontier based dynamic Louvain.
      auto b2 = louvainDynamicFrontierOmp(y, deletions, insertions, B2, VW, CW, {repeat});
      flog(b2, "louvainDynamicFrontierOmp");
      // Find static RAK (strict).
      auto f1 = rakStaticOmp(y, {repeat});
      flog(f1, "rakStaticOmp");
      // Find frontier based dynamic RAK (strict).
      auto f2 = rakDynamicFrontierOmp(y, deletions, insertions, F2, {repeat});
      flog(f2, "rakDynamicFrontierOmp");
      // Find frontier based dynamic Hybrid Louvain-RAK (strict).
      auto f3 = rakDynamicFrontierOmp(y, deletions, insertions, F3, {repeat});
      flog(f3, "louvainRakDynamicFrontierOmp");
      #if BATCH_LENGTH>1
      B2 = b2.membership;
      F2 = f2.membership;
      F3 = f3.membership;
      VW = b1.vertexWeight;
      CW = b1.communityWeight;
      #endif
    });
  });
}


/**
 * Main function.
 * @param argc argument count
 * @param argv argument values
 * @returns zero on success, non-zero on failure
 */
int main(int argc, char **argv) {
  using K = uint32_t;
  using V = TYPE;
  install_sigsegv();
  char *file     = argv[1];
  bool symmetric = argc>2? stoi(argv[2]) : false;
  bool weighted  = argc>3? stoi(argv[3]) : false;
  omp_set_num_threads(MAX_THREADS);
  LOG("OMP_NUM_THREADS=%d\n", MAX_THREADS);
  LOG("Loading graph %s ...\n", file);
  DiGraph<K, None, V> x;
  readMtxOmpW(x, file, weighted); LOG(""); println(x);
  if (!symmetric) { x = symmetricizeOmp(x); LOG(""); print(x); printf(" (symmetricize)\n"); }
  runExperiment(x);
  printf("\n");
  return 0;
}
#pragma endregion
#pragma endregion
