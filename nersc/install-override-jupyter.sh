#!/bin/bash

set -eo pipefail

script_dir="`cd $(dirname $0); pwd`"

cp -i ${script_dir}/.override-jupyter $HOME/

shifterimg -v pull docker:thewtex/sc20-pyhpc-nersc-dask:latest
