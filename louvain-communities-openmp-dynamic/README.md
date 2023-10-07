Design of OpenMP-based Dynamic [Louvain algorithm] for [community detection].

This is an implementation of the popular [Louvain algorithm]. It is an
**agglomerative-hierarchical** community detection method that *greedily*
*optimizes* for [modularity]. Given an undirected weighted graph, all
vertices are first considered to be their own communities. In the
**local-moving phase**, each vertex greedily decides to move to the community of
one of its neighbors which gives greatest increase in modularity (multiple
iterations). In the **aggregation phase**, all vertices belonging to a
community* are *collapsed* into a single *super-vertex*. This super-vertex
graph is then used as input for the next pass. The process continues until the
increase in modularity is below a certain threshold. As a result from each pass,
we have a *hierarchy of community memberships* for each vertex as a
**dendrogram**. See [extended report] for details. For IPDPS2024 submission, see
[submission-ipdps24].

There are three different dynamic approaches we are trying out:
- **Dynamic Delta-screening**: We find a set of affected vertices as per the [Delta-screening] paper.
- **Dyanmic Frontier**: We mark endpoints of each vertex as affected, and expand out iteratively.

The input data used for below experiments is available from the [SuiteSparse Matrix Collection].
The experiments were done with guidance from [Author2] and
[Author3].

[Louvain algorithm]: https://en.wikipedia.org/wiki/Louvain_method
[extended report]: https://gist.github.com/author1/91b2d2ac50b9aba6b203e88b291c7671
[submission-ipdps24]: https://github.com/author1/louvain-communities-openmp-dynamic/tree/submission-ipdps24
[community detection]: https://en.wikipedia.org/wiki/Community_search
[modularity]: https://en.wikipedia.org/wiki/Modularity_(networks)
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

[input-large]: https://github.com/author1/louvain-communities-openmp-dynamic/tree/input-large


<br>
<br>


## References

- [Fast unfolding of communities in large networks; Vincent D. Blondel et al. (2008)](https://arxiv.org/abs/0803.0476)
- [Community Detection on the GPU; Md. Naim et al. (2017)](https://arxiv.org/abs/1305.2006)
- [Scalable Static and Dynamic Community Detection Using Grappolo; Mahantesh Halappanavar et al. (2017)](https://ieeexplore.ieee.org/document/8091047)
- [From Louvain to Leiden: guaranteeing well-connected communities; V.A. Traag et al. (2019)](https://www.nature.com/articles/s41598-019-41695-z)
- [CS224W: Machine Learning with Graphs | Louvain Algorithm; Jure Leskovec (2021)](https://www.youtube.com/watch?v=0zuiLBOIcsw)
- [The University of Florida Sparse Matrix Collection; Timothy A. Davis et al. (2011)](https://doi.org/10.1145/2049662.2049663)
- [Fetch-and-add using OpenMP atomic operations](https://stackoverflow.com/a/7918281/1413259)
