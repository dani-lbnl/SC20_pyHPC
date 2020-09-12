FROM jupyter/scipy-notebook:6d42503c684f

LABEL maintainer="Matt McCormick <matt.mccormick@kitware.com>"

# Based on:
# https://gitlab.com/NERSC/nersc-notebooks/blob/master/dask/00-nersc-dask-gentle-introduction.ipynb
# "Rollin Thomas <rcthomas@lbl.gov>"

ENV DEBIAN_FRONTEND=noninteractive

USER root
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
USER jovyan

COPY environment.yml .
RUN conda env update -n base \
    environment.yml && \
    rm environment.yml
RUN conda install -y -c conda-forge \
        nodejs              \
        jupyterhub          \
        jupyterlab          \
        pip                 && \
        conda clean -y --all

# These currently failed on startup if installed via conda.
RUN \
    pip3 install            \
        mpi4py              \
        dask-mpi
RUN \
    jupyter labextension install \
      @jupyter-widgets/jupyterlab-manager \
      jupyter-matplotlib \
      jupyterlab-datawidgets \
      jupyterlab-datawidgets \
       @jupyterlab/hub-extension \
      jupyterlab-plotly@4.10.0 \
      plotlywidget@4.10.0 \
      itkwidgets@0.32.0

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG IMAGE=thewtex/sc20-pyhpc-nersc-dask
ARG VERSION=latest
ARG VCS_REF
ARG VCS_URL
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$IMAGE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.schema-version="1.0"
