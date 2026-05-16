---
title: "Partitioning large scale Morton-order grids using NVSHMEM"
lead: "A Space-filling Curve approach to GPU load balancing"
date: 2025-12-19
slug: "morton-nvshmem"
description: "Making Octree grids strongly and evenly scale with GPUs"
keywords: ["hpc", "gpu", "nvshmem", "cuda", "c++", "morton order", "load balancing"]
draft: false
tags: ["hpc", "gpu", "cuda", "research"]
math: true
toc: true
comments: true
plain_title: true
summary: Making Octree grids strongly and evenly scale with GPUs using Morton-codes, NVSHMEM and CUDA.
---

> The following is a **markdown port** of my work at the Jülich Supercomputing Centre.
>
> It might be a little bit terser and shoehorned than my normal writing - sorry!

---
---

## Abstract

Octrees are used universally in simulation software for modelling physical systems, most notably in N-body simulations used in various scientific applications such as cosmology. The underlying grids used in Octrees can span billions of cells in large environments, often distributed uniformly by space between nodes. This approach, however, when paired with the highly clustered data commonly found in N-body simulations, leads to an unbalanced allocation of work between the available nodes. This report proposes a distribution approach involving Morton order curves to partition the grid space, and presents an implementation of this method using NVSHMEM.

# Introduction

In N-body simulations, an environment is represented as a set of N objects in some space. Each body will apply some force to all the surrounding bodies, and, conversely, each body will move according to the net force exerted on it by all other bodies. Therefore, for each time step of an N-body simulation a total of \(N^2\) interactions need to be calculated.

Fortunately, bodies sufficiently far from a target body can be approximated as a single cumulative object - representing the net force of that cluster of bodies on the target. This significantly lowers the number of interactions we need to calculate and is the governing mechanism behind the current standard N-body algorithms such as Barnes Hut and the Fast Multipole Method.

However, the ability to efficiently locate these ’clusters’ and effectively query such information for every body is its own challenge. The Octree data structure is designed to tackle this problem by partitioning 3D space into 8 equal cubes recursively. Individual layers can store metadata, such as the cumulative sum of bodies at that node, or a centre of mass, meaning algorithms can deduce the counts and locations of far-field clusters from any given point within the partitioned space.

{{< img src="figure-1-1.png" width="82%" anchor="center" wrap="false" caption="Figure 1.1: [Oct/Quad tree layers](https://doi.org/10.1080/01431161.2013.838710)" >}}

Octrees have far more applications outside the scope of this report, most notably in rigid collision, where it serves as an effective representation for 3D meshes in irregular shapes, or in efficient rendering as a way of achieving frustum culling in detailed environments.

Figure 1.1 shows an example of an Octree partitioning a 3D space. Our current implementation will be working predominantly with a 2D coordinate system for simplicity of explanation and visualisation.

---
---

# Grid distribution approaches

We have established the necessity of Octrees and their underlying levelled grid structure when attempting to scale N-body simulations. We are often dealing with magnitudes of billions of bodies, which are all ultimately represented within the Octree’s structure. Given our compute, with some number of GPUs and nodes, how can we effectively allocate grid cells to each parallel process to minimise imbalance?

---

## Uniform distribution

A simple approach to allocation would be to effectively split our grid into even chunks of size \(\lfloor \frac{N}{p} \rfloor\) where N is the number of cells available at this depth and p being the number of processes we would like to dispatch.

{{< img src="figure-2-1.png" width="86%" anchor="center" wrap="false" caption="Figure 2.1: Uniform cell assignment as a distribution method" >}}

Figure 2.1 describes an example N-body simulation, set at an Octree level of depth 4x4. On a system of 16 processes we can therefore assign each processing element 1 cell to manage. The distribution could be done in a number of ways, such as in a row-by-row pattern or with alternating cells each taking their own processing element.

This method can be thought of as a spatial partitioning of the cell space. It assumes nothing of the distribution of the body positions and allocates work to a process according to the physical space on the grid the process occupies.

However, as direct interaction work is done between bodies at the leaf level rather than solely between the cells in the space itself, this approach can still be quite flawed. In 2.1 whilst some processes manage very few bodies, there is one noticeably unbalanced cell that contains a bulk of the densest cluster in the space. This disparity in allocation will leave parts of our available compute underutilised and therefore impact our efficiency.

---

## Morton partitioning

We established in the Uniform Distribution approach that distributing cells by space performs a perfectly balanced split. An ideal distribution method would be one that performs the same uniform split as discussed but along the dimension of bodies, as opposed to space.

When partitioning space in our Uniform method, we needed to find an orderable index for each cell, so that we could deduce the blocks to assign per process. In a similar fashion, if we were able to find an orderable index for the set of body positions, we could simply just assign processes along evenly spaced slices of that index.

In fact, this is possible by mapping the distinct body positions to a discrete grid. Assuming no two bodies are in the same position, we can guarantee a unique cell index for each body. This grid can then be used to assign processes to equal numbers of cells spatially, just like the Uniform Distribution method. However, since we now guarantee each cell to contain a body, we have reframed our ”dimension” of partitioning to the number of bodies as opposed to grid cells in space.

---

## Morton codes

{{< grid >}}
{{< img src="figure-2-2.png" width="100%" anchor="center" wrap="false" caption="Figure 2.2: [Morton code patterns.](https://commons.wikimedia.org/w/index.php?title=File:Four-level_Z.svg&oldid=976282662)" >}}
{{< img src="figure-2-3.png" width="100%" anchor="center" wrap="false" caption="Figure 2.3: [Binary coalescing for Morton codes.](https://commons.wikimedia.org/w/index.php?title=File:Z-curve45.svg&oldid=449766829)" >}}
{{< /grid >}}

### Morton Code background

Figures 2.2 and 2.3 describe the shape and function of the Morton curve. It is a common 1-dimensional encoding of any N-dimensional set of coordinates, forming a ”Z” shaped pattern as it traverses the coordinate space. Morton curves are guaranteed to cross every point in the coordinate space, thus being part of a class of coordinate encoders known as space-filling curves.

Morton codes are calculated by interweaving the binary representations of each coordinate. This is illustrated in 2.3. Such a calculation is easy to compute, and can be done with simple binary shifting.

Another advantage of Morton codes is that they preserve locality. This means that points that are close to each other in the coordinate space will also be close to each other in the Morton code space. Notice the ”square” shape of the Morton curve, and the lack of large jumps between points, like those you would find in a simple row major ordering.

Since the length of a Morton code is determined by the bit depth of its input coordinates, they also form splits similar to that of its representative Octree. This is demonstrated in 2.2 and even further improves on the access pattern of the Morton curve.

### Morton Code Slicing

{{< img src="figure-2-4.png" width="92%" anchor="center" wrap="false" caption="Figure 2.4: Morton code slicing example." >}}

Now that we have a process that encodes our coordinate space, and thus our set of bodies, into a 1 dimensional stream, we can simply distribute our bodies by taking slices of size \(\frac{N}{p}\) down the curve, where N is the total number of boxes and p is the number of processes we would like to distribute across. This slicing pattern is shown in 2.4, where we are provided a partial frame of the grid space, containing 32 cells. We cut slices of size 8 down the curve, each assigned a different colour, representative of the chunk’s respective process.

---
---

# Morton slicing implementation

So far, we have established the benefits of the proposed Morton distribution approach. However, given that bodies in the simulation may not necessarily communicate within the same managed chunk, we will need to establish some form of data exchange between the chunks, ensuring its safety and performance.

---

## Platform

There are several popular communication libraries, such as OpenMPI, IPC libraries like IceOryx, or lower-level communication frameworks like UCX.

However, the clusters commonly used in N-body simulations are highly GPU heavy and deal with large amounts of memory access/exchange. Communication libraries like OpenMPI tend to be CPU-based. This requires all information to be transferred from GPU to CPU memory before being sent over the network. This can lead to significant performance overhead and an unnecessary bottleneck.

In order to avoid this transfer altogether, we need to utilise the InfiniBand-based Remote Direct Memory Access (RDMA) provided by all enterprise NVIDIA hardware. The most established communication framework provided by NVIDIA for this is the NVIDIA Collective Communication Library (NCCL).

{{< img src="figure-3-1.png" width="84%" anchor="center" wrap="false" caption="Figure 3.1: [NVSHMEM’s one way communication model](https://developer.nvidia.com/nvshmem)" >}}

NCCL provides a similar interface to MPI for communication between GPUs. It is designed to be used with CUDA and can be used to perform collective operations as well as point-to-point communication.

Like MPI, NCCL is designed around two-sided communication, which means for every communication operation, there is a paired send and receive. Whilst this approach is sufficient, it requires an implicit buffer to be allocated to store intermediate data. It also implicitly synchronises the GPU operations, which can lead to unnecessary communication overhead.

In a one-sided communication model, the sender and receiver are decoupled, with synchronisation provided by the user. Processes can directly access and put data into each other’s memory, simplifying the communication process and reducing the overhead associated with data transfers.

An old but well-established one-way communication model is OpenSHMEM. By utilising shared memory, OpenSHMEM enables the direct memory access needed for decoupled communication between several processes. However, OpenSHMEM lacks RDMA support, falling for the same problems as OpenMPI and other CPU-based communication libraries.

NVSHMEM is NVIDIA’s solution to RDMA-based one-sided communication. [First introduced in 2017](https://doi.org/10.1109/HiPC.2017.00037), it provides a simple interface for one-sided communication between GPUs, allowing for low-overhead communication whilst minimising host data transfers. Figure 3.1 highlights this architectural shift, illustrating how data bypasses the CPU staging and implicit synchronisation required by traditional MPI approaches.

NVSHMEM is also useful for supporting both host and device side APIs, allowing for overlapping between communication and computation. Communication between nodes is usually done through IBGDA (InfiniBand GPUDirect Async); however, there are supported fallbacks, such as a CPU-based proxy thread, for nodes without IBGDA support.

The library is in its early stages, and has large parts of the API still to be implemented. This includes atomics on complex data types, such as doubles. This also includes a lack of support for collectives on intra-GPU process communication, meaning that in order for an NVSHMEM implementation to make use of API collective calls, the developer must allocate at most one processing element (PE) per GPU.

Regardless of the limitations, NVSHMEM is a promising solution for GPU-centric communication and provably the best candidate for our Morton chunk communication.

---

## Chunk communication pattern

With NVSHMEM, developers are now given full control of when to synchronise, as well as buffers to store communication state. The most commonly required communication from a chunk will be accessing and writing data to its immediate neighbours.

The diagonal and orthogonally adjacent cells of any chunk are known as its halo or ghost cells. These act as a buffer for data exchange between neighbouring chunks. They are used to store data temporarily during communication, ensuring that the data is always available for the next computation step.

A halo is periodic if it wraps around the grid, allowing for seamless communication between opposite edges. This is particularly useful for periodic boundary conditions in simulations, but can lead to unwanted edge cases where halo cells can intersect with the chunk cells themselves.

{{< img src="figure-3-2.png" width="78%" anchor="center" wrap="false" caption="Figure 3.2: chunk periodic halos." >}}

Figure 3.2 shows 4 separate chunk diagrams, one for each of the 4 Morton slices of a 16x16 grid. The red and orange cells represent the domain of the chunk itself whilst green cells indicate halo zones. Notice edge scenarios such as corner green cells, and the other various ways periodic halos form around the chunk.

During any necessary halo cell reads, a chunk will always maintain an up-to-date value of its halo cells, without having to directly access neighbour chunks. This allows for the halo to act as a ”buffer” layer for our communication pattern.

---

## Halo calculations

Calculating the halo cells involves breaking out of our SFC domain and returning to Cartesian coordinates. The conversion causes no sizeable overhead, as it involves a \(O(1)\) set of bit shifts. However, determining the size of the halo cells and then populating without forming data races or duplicates is more challenging. We outline a four-stage process to achieve this efficiently.

### Stage 1: Counting Halo Neighbours

Firstly, the `halo_count` kernel is launched. Threads are assigned to each cell in the chunk, inspecting its eight neighbours. If a neighbour’s Morton code falls outside the local chunk’s range [start, end], it is a halo cell and a local counter is incremented. The final count for each cell is written to a global `d_counts` array, which will serve as the input for the next stage.

{{< img src="figure-3-3.png" width="42%" anchor="right" wrap="true" caption="Figure 3.3: example cell count" >}}

### Stage 2: Calculating Memory Offsets (Scan)

To write halo data in parallel without data races, we must first determine where each thread should write. This is achieved with a parallel prefix sum (or inclusive scan) on the `d_counts` array generated in the previous stage. We use the high-performance `thrust::inclusive_scan` function for this. The operation transforms the array of raw counts into an array of memory offsets, as shown in Table 3.1. Each element becomes the sum of itself and all preceding counts, giving each cell a unique end boundary for writing its halo data. The last element of the array now conveniently holds the total number of (non-unique) halo cells.

| Stage | Cell 0 | Cell 1 | Cell 2 | Cell 3 |
| --- | ---: | ---: | ---: | ---: |
| Counts | 3 | 5 | 2 | 3 |
| Offsets | 3 | 8 | 10 | 13 |

Table 3.1: Transformation of raw counts into memory offsets via an inclusive scan.

### Stage 3: Populating the Halo Array

With memory offsets calculated, the `halo_populate` kernel is launched. Its internal logic is nearly identical to `halo_count`, identifying halo cells in the same way. It then uses the pre-computed offsets to write the Morton code of each discovered halo cell into the correct position in a large, contiguous `d_halo` array. Each thread writes to its own designated block of memory, guaranteeing a race-free parallel operation.

### Stage 4: Removing Duplicates

The populated halo array will contain duplicates, as multiple chunk cells can be adjacent to the same halo cell. These are removed using `thrust::sort`, which groups identical Morton codes together, followed by `thrust::unique`, which collapses consecutive duplicates into single entries. This yields the final minimal set of halo cells.

---
---

# Communication

---

## Parallel writing

Now that we have a clean structure providing us the Morton indices for any given chunk’s halo, we can start with some form of communication to exchange halo data. Parallel writes between neighbouring chunks are difficult due to the potential for data races and inconsistencies. To better describe this, we can implement a simple scatter operation, that reads and increments the values of all halo cells for each chunk. On a 16x16 grid initialised to zero, one would expect the inner cells of each chunk to be incremented by 1 for every halo intersecting with that cell.

{{< img src="figure-4-1.png" width="88%" anchor="center" wrap="false" caption="Figure 4.1: Race condition within intersecting halos." >}}

Figure 4.1 illustrates the read-modify-write race condition that occurs in this scenario. corner cells should have values of 3, yet in several cells the values are not consistent. Refer back to Figure 3.2 to better visualise the intersecting halo cells.

### Solution 1: Atomic writes

The NVSHMEM API luckily provides us with a set of atomic procedures that can be used to safely update shared memory locations. We could use `nvshmem_TYPE_atomic_inc` as an example.

As an NVSHMEM primitive, we can assume the implementations of this operation are performant and safe. On a 4 GPU single node system, the atomic scatter implementation performed on average 5x slower than the non-atomic version on a batch of 10 million iterations. The overhead of atomic operations having to synchronise all our processing elements is the primary cause of this degraded performance.

### Solution 2: Buffering

An alternative approach would be to allow each cell to maintain a ”buffer” pool of memory, to which other processes can write to, within their own undisrupted memory space. Afterwards the buffer’s contents can be synchronously flushed into the cell’s contents and therefore requiring only a single atomic operation for flushing this buffer.

{{< img src="figure-4-2.png" width="42%" anchor="right" wrap="true" caption="Figure 4.2: Buffer approach" >}}

This approach achieves only a 40-50% performance degradation to our raw scatter operation, and scales far better than the atomic approach.

However, there are still a few limitations to this approach. Firstly, whilst only 32 bytes of storage (for integers) may seem minimal in terms of memory usage, there is still a large potential for memory blow up. For example, we have so far only been considering ’single layered’ halos, also known as a Moore neighbourhood, which describes direct neighbours of cells. However, for multi-tiered halos, the number of cells grows quadratically, with up to 440 cells capable within reach at a layer 10 halo, which would need 1.7K bytes of storage per cell. On a 3D space, with cubic growth, a 10 layer halo would require almost 37K bytes of storage per cell.

| Layer size | 1 | 2 | 4 | 8 | 16 | 32 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| 2D | 32B | 96B | 320B | 1.2KB | 4.4KB | 16.9KB |
| 3D | 104B | 496B | 2.9KB | 19.6KB | 144KB | 1MB |

Table 4.1: Memory blow up example

### Solution 3: Adaptive Buffering

We established that whilst the buffering method was effective, its memory consumption made the approach impractical for large scale simulations. To address this, we propose an adaptive buffering scheme, which dynamically adjusts the buffer size based on the number of potential neighbouring chunks, instead of maintaining an upper bound.

{{< img src="figure-4-3.png" width="62%" anchor="center" wrap="false" caption="Figure 4.3: Adaptive Buffer approach" >}}

This is achieved by including an additional step during the initialisation of each chunk. Since every chunk is required to know the Morton slice ranges of each process before proceeding with any communication, this step can also be used to calculate the number of chunks reachable within each inner cell of the chunk. This is possible in linear time with a negligible overhead as no additional collective calls are required.

On a single layer halo, we found that most cells interact with cells that are owned by 1 or 2 chunks. We have, therefore, reduced the average byte size per cell from 32 to 8 bytes. On a 3D, 10 layer halo system, if assuming an average 20 chunks within the halo, the average byte size per cell is reduced to 6.7K bytes, a reduction of almost 82%.

---
---

# Discussion and Future Work

This report contributes a novel approach to the distribution of grid-based workloads in GPU-centric clusters, from the perspective of N-body simulations. Using Morton curves, GPU-GPU communication with NVSHMEM, and adaptive buffers to transfer data race-free, we achieve significant performance improvement over existing CPU-centric or two way communication schemes.

On average this approach, compared to a CUDA-aware MPI implementation on 16 GPUs between 4 nodes:

• Achieves a 40-50% lower latency for halo communication.

• Reduces variable memory consumption by 82%.

• Contains zero host data transfers during communication.

Scaling between 8-GPU and 16-GPU systems also suggests both the latency improvement and variable memory consumption reduction to continue improving at larger scales - however further testing is required to confirm this.

---

## NVSHMEM limitations

The use of NVSHMEM contributed greatly to the performance of our load balancing system. However, there are some limiting factors of the API that are currently hindering the scalability and performance of the system.

NVSHMEM is still early in its development, and will take a few years to mature. Currently, atomic operations are only supported for a select few data types. Support for the API is also heavily limited when working with intra-GPU processes, which makes a vast part of the project only feasible when processes are bound uniquely to GPUs.

---

## Hardware limitations

During development of the project, the unavailability of some low-level drivers may have limited the performance, as fallbacks from IBGDA would result in fewer NVSHMEM calls utilising GPU-GPU direct communication. These results have been omitted from the report, however they must be considered when considering the portability of the system.

---

## Future Work

There are still several directions to improve this work. With these initial steps, the project can be scalable, portable and more practical when integrating into standardised simulation codes.

### 3D implementation

The Morton slicing scheme and distribution proposed in this report is currently only available in a 2D grid context. For the library to perform on real-world simulations, a 3D implementation is a necessary first step forward in development of this approach. This will not require any significant change, but will intensify any bottlenecks that may be present in the implementation.

### Multi-tier halo

Currently, communication is only supported on a neighbouring cell basis, as halos are currently confined to a 1-cell distance from the Chunk. In more practical use cases, halo distances of 2,3 or 10 are necessary in order for cells to access the more far-reaching areas of the grid. Like before, this will also intensify any current bottlenecks due to the higher complexity of the chunks.

### Adaptive tree methods

An alternative approach not discussed in Section 2 is the idea of using an adaptive distribution.

This approach utilises a separate octree, which is subdivided until each leaf node covers a maximum of \(\lceil n/p \rceil\) bodies, where n is the total number of bodies and p is the target number of processes.

{{< img src="figure-5-1.png" width="62%" anchor="center" wrap="false" caption="Figure 5.1: The Adaptive Distribution." >}}

The partitioning is shown in figure 5.1, where leaves are non-uniform in size but maintain a consistent count of bodies.

This structure is simpler to implement than Morton slicing, as the grid space is partitioned in consistently cubic shapes, unlike the irregular partitions common along a Morton curve.

Unlike Morton slicing, which treats the particle set as a continuous stream allowing for arbitrary partition boundaries, adaptive distribution is constrained by the discrete geometry of the tree. This rigid granularity could impede load balancing.

For future benchmarking, the proposed Morton curve distribution should be tested against an adequate implementation of the adaptive method.

### Higher efficiency kernel design

The halo calculation kernel, currently is sufficiently performant such that it does not interfere with recording the performance of communication. However, there will be more extreme scenarios where the kernel could impact system-wide performance, especially if handling multi-tiered halos. The current 4-stage process could be interleaved between CUDA streams, and could certainly utilise shared memory.

---
---

# Acknowledgments

I would like to thank my supervisors, Ioannis Lilikakis and Ivo Kabadshow, for their guidance and support throughout this project. There were several roadblocks during the implementation and design where their guidance was invaluable.
