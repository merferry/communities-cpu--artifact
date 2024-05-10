I want to keep track of changes to the plot scripts for Community detection.

<br>
<br>


## Build instructions

To generate the plots using `gnuplot`, run the following commands:

```bash
## For the Louvain algorithm
$ gnuplot louvain-am.plt
$ gnuplot louvain-all.plt

## For the RAK algorithm
$ gnuplot rak-am.plt
$ gnuplot rak-all.plt

## For the Hybrid Louvain-RAK algorithm
$ gnuplot hybrid-am.plt
$ gnuplot hybrid-all.plt

## For the strong scaling behavior Hybrid Louvain-RAK
$ gnuplot hybrid-amss.plt
$ gnuplot hybrid-allss.plt
```
