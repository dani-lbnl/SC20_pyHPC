#!/bin/bash

prefix=$HOME/.local/share/jupyter/kernels/sc20-pyhpc-nersc-dask
mkdir -p $prefix
cp -i kernel.json $prefix/kernel.json

shifterimg -v pull docker:thewtex/sc20-pyhpc-nersc-dask:latest
