Design of OpenMP-based Dynamic [RAK] algorithm for [community detection].

This is an implementation of a popular label-propagation based community
detection algorithm called **Raghavan Albert Kumara (RAK)**. Here, every node is
initialized with a unique label and at every step each node adopts the label
that most of its neighbors currently have. In this iterative process densely
connected groups of nodes form a consensus on a unique label to form
communities. See [extended report] for details. For IPDPS2024 submission, see
[submission-ipdps24].

There are three different dynamic approaches we are trying out:
- **Dynamic Delta-screening**: We find a set of affected vertices as per the [Delta-screening] paper.
- **Dyanmic Frontier**: We mark endpoints of each vertex as affected, and expand out iteratively.

The input data used for below experiments is available from the [SuiteSparse Matrix Collection].
The experiments were done with guidance from [Author2] and
[Author3].

[RAK]: https://arxiv.org/abs/0709.2938
[extended report]: https://gist.github.com/author1/91b2d2ac50b9aba6b203e88b291c7671
[submission-ipdps24]: https://github.com/author1/rak-communities-openmp-dynamic/tree/submission-ipdps24
[community detection]: https://en.wikipedia.org/wiki/Community_search
[sequential]: https://github.com/author1/rak-communities-static-vs-dynamic
[Delta-screening]: https://ieeexplore.ieee.org/document/9384277
[Author3]: https://www.example.com/
[Author2]: https://www.example.com/
[SuiteSparse Matrix Collection]: https://sparse.tamu.edu

<br>


## Build instructions

To run the [input-large] experiment, download this repository and run the
following. Note that input graphs must be placed in `~/Data` directory, and
output logs will be written to `~/Logs` directory.

```bash
# Perform comparision on large graphs
$ DOWNLOAD=0 ./mains.sh

# Perform comparision on large graphs with custom number of threads
$ DOWNLOAD=0 MAX_THREADS=4 ./mains.sh
```

<br>
<br>


## References

- [Near linear time algorithm to detect community structures in large-scale networks; Usha Nandini Raghavan et al. (2007)](https://arxiv.org/abs/0709.2938)
- [Delta-Screening: A Fast and Efficient Technique to Update Communities in Dynamic Graphs](https://ieeexplore.ieee.org/document/9384277)
- [The University of Florida Sparse Matrix Collection; Timothy A. Davis et al. (2011)](https://doi.org/10.1145/2049662.2049663)
- [How to import VSCode keybindings into Visual Studio?](https://stackoverflow.com/a/62417446/1413259)
- [Configure X11 Forwarding with PuTTY and Xming](https://www.centlinux.com/2019/01/configure-x11-forwarding-putty-xming-windows.html)
- [Installing snap on CentOS](https://snapcraft.io/docs/installing-snap-on-centos)
