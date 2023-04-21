This is the computational artifact for the paper **Shared-Memory Parallel**
**Algorithms for Community Detection in Dynamic Graphs**. It includes the source
code for *three experiments* and the source code for *generating plots* in four
separate directories.

1. `louvain-communities-openmp-dynamic/` contains the source code for the
   experiment which compares the performance of *Static*, *Naive-dynamic*,
   *Dynamic Delta-screening*, and *Dynamic Frontier* based *Louvain*.
2. `rak-communities-openmp-dynamic/` contains the source code for the experiment
   which compares the performance of *Static*, *Naive-dynamic*, *Dynamic*
   *Delta-screening*, and *Dynamic Frontier* based *LPA* (aka *RAK*).
3. `communities-openmp-dynamic/` contains the source code for the experiment
   which compares the performance of *Dynamic Frontier* based *Louvain*, *LPA*,
   and *Hybrid Louvain-LPA*. It also includes the script (and steps) to run the
   strong scaling experiment.
4. `gnuplot-scripts-communities-cpu/` contains the source code for generating
   the plots for the experiments.

<br>


### Dependencies and requirements

We run all experiments on a *DGX Station A100* running *Ubuntu 20.04*, with
simultaneous multi-threading (SMT) enabled. To compile the source code, we use
*GCC 9.4* and *OpenMP 5.0* with optimization level `-O3`. Executing the build
and run script requires `bash`, and `tmux` or similar is needed to keep the
experiment running in a separate terminal in the background. Additionally,
*Node.js 18 LTS* is needed to process generated output into *CSV*, *Google*
*sheets* is needed to generate charts and summarized CSVs, and *gnuplot 5.4* is
needed to generate the plot from summarized CSVs. The specification our machine
is as follows:

```
NVIDIA DGX Station A100
Proc:  AMD EPYC 7742 64-Core CPU @ 2.25GHz (64 cores x 2)
Cache: L1d+i: 4MB, L2: 32MB, L3: 256MB (shared), NUMA: 4 (internal)
Mem:   512GB System Memory
Disk:  Micron 7300 PRO 1.92TB NVMe; KIOXIA KCM6DRUL7T68 7.68TB NVMe
Net:   Intel Ethernet Controller 10G X550T (10 Gbit/s)
Disp:  4 x NVIDIA A100-SXM4-80GB; 12 x NVLink @ 25GBPS (Total 320GB)
Disp:  ASPEED Graphics VGA controller; NVIDIA DGX Display (33MHz)
OS:    Ubuntu 20.04.4 LTS (Focal Fossa, Linux 5.4.0-113-generic)
```

We use `13` graphs in *Matrix Market (.mtx)* file format from the *SuiteSparse*
*Matrix Collection* as our input dataset. These must be placed in the `~/Data`
directory **before running** the experiments. In addition, a `~/Logs` directory
**must be created**, where the output logs of each experiment are written to.
Please use `setup.sh` in the current directory to create the necessary
directories and download the input dataset. The graphs in the **input dataset**
are as follows:

```
indochina-2004.mtx
uk-2002.mtx
arabic-2005.mtx
uk-2005.mtx
webbase-2001.mtx
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
order to run the experiment. To run an experiment, try `DOWNLOAD=0 ./mains.sh`
from a `bash` shell. Please refer to any additional details in the `README.md`
of each experiment (such as controlling the number of threads, if needed). Each
experiment takes around 2 days to complete. Output logs are written to the
`~/Logs` directory. These logs can be processed with the `process.js` script to
generate a *CSV* file as follows:

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
2. Use `tmux` to run the experiment in a separate terminal in the background.
3. Run an experiment of choice with `DOWNLOAD=0 ./mains.sh` in respective
   subdirectory.
4. Output of the experiment is written to `~/Logs` directory.
5. Process the output logs into CSV with `node process.js csv ~/Logs/"experiment".log "experiment".csv`.
6. Import the CSV into the `data` sheet of the linked **sheets** document of the
   experiment.
7. All the charts are automatically updated. See `"graph"` sheet for results on
   a specific input graph, or the `all` sheet for the average result on all
   input graphs.
8. Use the `csv` sheet to retrieve summarized CSVs.
9. Use the summarized CSVs to generate plots using the `gnuplot` scripts in the
   `gnuplot-scripts-communities-cpu` subdirectory.
10. Compare the generated plots with that of the paper.

Each experiment takes around 2 days to complete.
