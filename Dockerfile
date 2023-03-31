FROM nvidia/cuda:11.6.0-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install dependencies
RUN apt-get update && \
    apt-get install -y gnupg2 curl && \
    apt-get install software-properties-common -y && \
    add-apt-repository ppa:deadsnakes/ppa -y

RUN apt-get update && \
    apt-get install -y \
    python3.10-dev python3.10-distutils git git-lfs libgl1 libglib2.0-0 libsm6 libxext6 libxrender-dev x11-apps \
    make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
    libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev \
    liblzma-dev python-openssl tmux vim less \
    libfreetype6-dev libpng-dev sudo && \
    rm -rf /var/lib/apt/lists/*

# Set python3.10 as the default python interpreter
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

# Install pip
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
RUN update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.10 1

# Install pytorch libs
RUN pip install --upgrade pip setuptools
RUN pip install torch torchvision
RUN pip install --ignore-installed PyYAML

WORKDIR /app
COPY ./lit-llama /app/lit-llama

# Install requirements
WORKDIR /app/lit-llama
RUN pip install -r requirements.txt
RUN pip install -e .
RUN pip install jupyterlab

# Set up the entry location
WORKDIR /app
