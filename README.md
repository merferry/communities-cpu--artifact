This is the computational artifact for the paper **Shared-Memory Parallel**
**Algorithms for Community Detection in Dynamic Graphs**. It includes the source
code for *three experiments* and the source code for *generating plots* in four
separate directories.

1. `louvain-communities-openmp-dynamic/` contains the source code for the
   experiment which compares the performance of *Static*
   *Dynamic Delta-screening*, and *Dynamic Frontier* based *Louvain*.
2. `rak-communities-openmp-dynamic/` contains the source code for the experiment
   which compares the performance of *Static*, *Dynamic*
   *Delta-screening*, and *Dynamic Frontier* based *LPA* (aka *RAK*).
3. `communities-openmp-dynamic/` contains the source code for the experiment
   which compares the performance of *Dynamic Frontier* based *Louvain*, *LPA*,
   and *Hybrid Louvain-LPA*. It also includes the script (and steps) to run the
   strong scaling experiment.
4. `scripts-gnuplot/` contains the source code for generating
   the plots for the experiments.

<br>


### Dependencies and requirements

We run all experiments a server that has an AMD EPYC-7742 64-bit processor. This
processor has a clock frequency of 2.25 GHz and 512 GB of DDR4 system memory.
The CPU has 64 x86 cores and each core runs two hyper-threads. Each core has L1
cache of 4 MB, L2 cache of 32 MB, and a shared L3 cache of 256 MB. The machine
runs on *Ubuntu 20.04*. It is possible to run the experiment on any 64-bit
system running a recent version of Linux by configuring the number of threads to
use for the experiment. We use *GCC 9.4* and *OpenMP 5.0* to compile with
optimization level 3 (`-O3`). Executing the build and run script requires
`bash`. Additionally, *Node.js 18 LTS* is needed to process generated output
into *CSV*, *Google* *sheets* is needed to generate charts and summarized CSVs,
and *gnuplot 5.4* is needed to generate the plot from summarized CSVs.

We use `13` graphs in *Matrix Market (.mtx)* file format from the *SuiteSparse*
*Matrix Collection* as our input dataset. These must be placed in the `~/Data`
directory **before running** the experiments. In addition, a `~/Logs` directory
**must be created**, where the output logs of each experiment are written to.
Please use `setup.sh` in the current directory to create the necessary
directories and download the input dataset. The graphs in the **input dataset**
are as follows:

```
it-2004.mtx
sk-2005.mtx
com-LiveJournal.mtx
com-Orkut.mtx
asia_osm.mtx
europe_osm.mtx
kmer_A2a.mtx
kmer_V1r.mtx
```

<br>


### Installation and deployment process

Each experiment includes a `mains.sh` file which needs to be **executed** in
order to run the experiment. To run an experiment, try the following:

```bash
# Run experiment with a default of 64 threads
$ DOWNLOAD=0 ./mains.sh

# Run experiment with 32 threads
$ DOWNLOAD=0 MAX_THREADS=32 ./mains.sh
```

Please refer to any additional details in the `README.md` of each experiment.
Output logs are written to the `~/Logs` directory. These logs can be processed
with the `process.js` script to generate a *CSV* file as follows:

```bash
$ node process.js csv ~/Logs/"experiment".log "experiment".csv
```

The generated *CSV* file can be loaded into the `data` sheet of the linked
**sheets** document in the respective experiment. Ensure that there are no
newlines at the end of the `data` sheet after loading. All the charts are then
automatically updated. See `"graph"` sheet for results on a specific input
graph, or the `all` sheet for the average result on all input graphs. You can
then use the `csv` sheet to retrieve *summarized CSVs* which can be used to
generate plots using the `gnuplot` scripts in the
`gnuplot-scripts-communities-cpu` directory.

<br>


### Reproducibility of Experiments

The workflow of each experiment is as follows:

1. Setup the necessary directories and download the input dataset with
   `setup.sh`.
2. Run an experiment of choice with `DOWNLOAD=0 ./mains.sh` in respective
   subdirectory.
3. Output of the experiment is written to `~/Logs` directory.
4. Process the output logs into CSV with `node process.js csv ~/Logs/"experiment".log "experiment".csv`.
5. Import the CSV into the `data` sheet of the linked **sheets** document of the
   experiment.
6. All the charts are automatically updated. See `"graph"` sheet for results on
   a specific input graph, or the `all` sheet for the average result on all
   input graphs.
7. Use the `csv` sheet to retrieve summarized CSVs.
9. Use the summarized CSVs to generate plots using the `gnuplot` scripts in the
   `gnuplot-scripts-communities-cpu` subdirectory.
9. Compare the generated plots with that of the paper.
