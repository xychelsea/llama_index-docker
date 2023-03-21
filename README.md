# llama_index environment for anaconda with NVIDIA GPU and JupyterLab support

LlamaIndex (formerly known as GPT Index) is a project that provides a central interface to connect your large language model (LLM) with external data sources.

These containers provide options for an [NVIDIA GPU-enabled](https://hub.docker.com/r/nvidia/cuda) lightweight (Miniconda) [Anaconda](https://anaconda.com/) installation. Anaconda is an open data science platform based on Python 3. Based on a container with installed Anaconda into the ```/usr/local/anaconda``` directory. The default user, ```anaconda``` runs a [Tini shell](https://github.com/krallin/tini/) ```/usr/bin/tini```, and comes preloaded with the ```conda``` command in the environment ```$PATH```. Additional versions with [NVIDIA/CUDA](https://hub.docker.com/r/nvidia/cuda/) support and [Jupyter Notebooks](https://jupyter.org/) tags are available.

llama_index with anaconda3 and conda-forge
-----

This container enables the ```conda``` command with a lightweight version of Anaconda (Miniconda) and the ```conda-forge``` [repository](https://conda-forge.org/) in the ```/usr/local/anaconda``` directory. The default user, ```anaconda``` runs a [Tini shell](https://github.com/krallin/tini/) ```/usr/bin/tini```, and comes preloaded with the ```conda``` command in the environment ```$PATH```. Additional versions with [NVIDIA/CUDA](https://hub.docker.com/r/nvidia/cuda/) support and [Jupyter Notebooks](https://jupyter.org/) tags are available.

### NVIDIA/CUDA GPU-enabled Containers

Two flavors provide an [NVIDIA GPU-enabled](https://hub.docker.com/r/nvidia/cuda) container with [Anaconda](https://anaconda.com/).

## Getting the containers

### Vanilla llama_index

The base container, based on the ```ubuntu:latest``` from [Ubuntu](https://hub.docker.com/_/ubuntu/) running a Tini shell. For the container with a ```/usr/bin/tini``` entry point, use:

```bash
docker pull xychelsea/llama_index:latest
```

With Jupyter Notebooks server pre-installed, pull with:

```bash
docker pull xychelsea/llama_index:latest-jupyter
```

### Anaconda with NVIDIA/CUDA GPU support

Modified version of ```nvidia/cuda:latest``` container, with support for NVIDIA/CUDA graphical processing units through the Tini shell. For the container with a ```/usr/bin/tini``` entry point:

```bash
docker pull xychelsea/llama_index:latest-gpu
```

With Jupyter Notebooks server pre-installed, pull with:

```bash
docker pull xychelsea/llama_index:latest-gpu-jupyter
```

## Running the containers

To run the containers with the generic Docker application or NVIDIA enabled Docker, use the ```docker run``` command.

### Vanilla llama_index

```bash
docker run --rm -it xychelsea/llama_index:latest
```

With Jupyter Notebooks server pre-installed, run with:

```bash
docker run --rm -it -d -p 8888:8888 xychelsea/llama_index:latest-jupyter
```
### Anaconda with NVIDIA/CUDA GPU support

```bash
docker run --gpus all --rm -it xychelsea/llama_index:latest-gpu /bin/bash
```

With Jupyter Notebooks server pre-installed, run with:

```bash
docker run --gpus all --rm -it -d -p 8888:8888 xychelsea/llama_index:latest-gpu-jupyter
```

## Building the containers

To build either a GPU-enabled container or without GPUs, use the [xychelsea/llama_index-docker](https://github.com/xychelsea/llama_index-docker) GitHub repository.

```bash
git clone git://github.com/xychelsea/llama_index-docker.git
```

### Vanilla llama_index

The base container, based on the ```ubuntu:latest``` from [Ubuntu](https://hub.docker.com/_/ubuntu/) running Tini shell:

```bash
docker build -t xychelsea/llama_index:latest -f Dockerfile .
```

With Jupyter Notebooks server pre-installed, build with:

```bash
docker build -t xychelsea/llama_index:latest-jupyter -f Dockerfile.jupyter .
```

### llama_index with NVIDIA/CUDA GPU support

```bash
docker build -t xychelsea/llama_index:latest-gpu -f Dockerfile.nvidia .
```

With Jupyter Notebooks server pre-installed, build with:

```
docker build -t xychelsea/llama_index:latest-gpu-jupyter -f Dockerfile.nvidia-jupyter .
```

## References

- [llama_index](https://github.com/jerryjliu/llama_index)
- [Anaconda 3](https://www.anaconda.com/blog/tensorflow-in-anaconda)
- [conda-forge](https://conda-forge.org/)
