# llama_index Dockerfile for Anaconda3 / Miniconda3
# Copyright (C) 2020-2023  Chelsea E. Manning
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

FROM xychelsea/anaconda3:v22.11.1
LABEL description="llama_index Vanilla Container"

# $ docker build --network=host -t xychelsea/llama_index:latest -f Dockerfile .
# $ docker run --rm -it xychelsea/llama_index:latest /bin/bash
# $ docker push xychelsea/llama_index:latest

ENV ANACONDA_ENV=llama_index
ENV LLAMA_INDEX_PATH=/usr/local/llama_index
ENV LLAMA_INDEX_VERSION=v0.4.38

# Start as root
USER root

# Update packages
RUN apt-get update --fix-missing \
    && apt-get -y upgrade \
    && apt-get -y dist-upgrade

# Install dependencies
RUN apt-get install --no-install-recommends --no-install-suggests -y \
    git

# Create llama_index directory
RUN mkdir -p ${LLAMA_INDEX_PATH} \
    && fix-permissions ${LLAMA_INDEX_PATH}

# Switch to user "anaconda"
USER ${ANACONDA_UID}
WORKDIR ${HOME}

# Update conda env
RUN conda update -c defaults conda

# add llama_index repository to docker image
RUN git clone https://github.com/jerryjliu/llama_index ${LLAMA_INDEX_PATH} \
    && git config --global --add safe.directory ${LLAMA_INDEX_PATH}

# checkout llama_index branch
WORKDIR ${LLAMA_INDEX_PATH}
RUN git checkout ${LLAMA_INDEX_VERSION}

# Add llama_index directory to home
RUN fix-permissions ${LLAMA_INDEX_PATH} \
    && ln -s ${LLAMA_INDEX_PATH} ${HOME}/llama_index

# create environment
RUN conda create -n ${ANACONDA_ENV} -c conda-forge

# install dependencies
RUN conda install -n ${ANACONDA_ENV} -c conda-forge \
    aiohttp=3.8.4 \ 
    aiosignal=1.3.1 \
    async-timeout=4.0.2 \
    attrs=22.2.0 \
    backcall=0.2.0 \
    certifi=2022.12.7 \
    charset-normalizer=2.1.1 \
    dataclasses-json=0.5.7 \
    decorator=5.1.1 \
    dill=0.3.6 \
    executing=1.2.0 \
    flake8=6.0.0 \
    frozenlist=1.3.3 \
    greenlet=2.0.2 \
    iniconfig=2.0.0 \
    jedi=0.18.2 \
    lazy-object-proxy=1.9.0 \
    marshmallow=3.19.0 \
    marshmallow-enum=1.5.1 \
    matplotlib-inline=0.1.6 \
    mypy=0.991 \
    mypy_extensions=1.0.0 \
    numpy=1.24.2 \
    pandas=1.5.3 \
    pathspec=0.11.1 \
    parso=0.8.3 \
    pexpect=4.8.0 \
    pickleshare=0.7.5 \
    pip=23.0.1 \
    platformdirs=3.1.1 \
    pluggy=1.0.0 \
    prompt-toolkit=3.0.38 \
    ptyprocess=0.7.0 \
    pydantic=1.10.6 \
    pydocstyle=6.3.0 \
    pygments=2.14.0 \
    pytest-dotenv=0.5.2 \
    python-dotenv=1.0.0 \
    python=3.11.0 \
    pyyaml=6.0 \
    rake_nltk=1.0.6 \
    requests=2.28.2 \
    stack_data=0.6.2 \
    snowballstemmer=2.2.0 \
    tenacity=8.2.2 \
    tiktoken=0.3.2 \
    tomlkit=0.11.6 \
    types-docutils=0.19.1 \
    types-setuptools=67.1.0.0 \
    types-urllib3=1.26.25 \
    typing_inspect=0.8.0 \
    urllib3=1.26.15 \
    wcwidth=0.2.6 \
    wrapt=1.15.0 \
    yarl=1.8.2

WORKDIR ${LLAMA_INDEX_PATH}

# Build llama_index
RUN conda run -n ${ANACONDA_ENV} pip install -r ${LLAMA_INDEX_PATH}/requirements.txt

# Switch back to root
USER root

# Clean up anaconda
RUN conda clean -afy

# Clean packages and caches
RUN apt-get --purge -y autoremove git \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* \
    && rm -rvf /home/${ANACONDA_PATH}/.cache/yarn \
    && fix-permissions ${HOME} \
    && fix-permissions ${ANACONDA_PATH}

# Re-activate user "anaconda"
USER $ANACONDA_UID
WORKDIR $HOME
