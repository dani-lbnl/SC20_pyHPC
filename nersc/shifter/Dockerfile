FROM ubuntu:18.04

LABEL maintainer="Matt McCormick <matt.mccormick@kitware.com>"

# Based on:
# https://gitlab.com/NERSC/nersc-notebooks/blob/master/dask/00-nersc-dask-gentle-introduction.ipynb
# "Rollin Thomas <rcthomas@lbl.gov>"

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /srv

RUN \
    apt-get update      &&  \
    apt-get install         \
        --yes               \
        automake-1.15       \
        autoconf            \
        autotools-dev       \
        binutils            \
        curl                \
        gfortran            \
        graphviz            \
        libtool             \
        libyaml-tiny-perl   \
        python3-pip         \
        wget                \
        build-essential

RUN \
    wget http://www.mpich.org/static/downloads/3.3.2/mpich-3.3.2.tar.gz &&  \
    tar xvzf mpich-3.3.2.tar.gz     &&  \
    cd mpich-3.3.2                  &&  \
    autoreconf --install --force    &&  \
    ./configure                     &&  \
    make -j 4                       &&  \
    make install                    &&  \
    make clean                      &&  \
    cd ..                           &&  \
    rm mpich-3.3.2.tar.gz

RUN \
    curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    rm nodesource_setup.sh   && \
    apt-get install --yes nodejs && \
    nodejs -v

RUN \
    pip3 install            \
        --no-cache-dir      \
        --user              \
        --upgrade           \
        setuptools

COPY requirements.txt .
RUN \
    pip3 install            \
        -r requirements.txt
RUN \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib jupyterlab-datawidgets itkwidgets

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG IMAGE=thewtex/fibercam-nersc-dask
ARG VERSION=latest
ARG VCS_REF
ARG VCS_URL
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$IMAGE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.schema-version="1.0"
