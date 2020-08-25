#!/usr/bin/env bash

set -eo pipefail

script_dir="`cd $(dirname $0); pwd`"

TAG=$(date '+%Y%m%d')-$(git rev-parse --short HEAD)

cp requirements.txt $script_dir

docker build "$@" -t thewtex/sc20-pyhpc-nersc-dask:latest \
        --build-arg IMAGE=thewtex/sc20-pyhpc-nersc-dask \
        --build-arg VCS_REF=`git rev-parse --short HEAD` \
        --build-arg VCS_URL=`git config --get remote.origin.url` \
        --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
        $script_dir
docker build "$@" -t thewtex/sc20-pyhpc-nersc-dask:${TAG} \
        --build-arg IMAGE=thewtex/sc20-pyhpc-nersc-dask \
        --build-arg VERSION=${TAG} \
        --build-arg VCS_REF=`git rev-parse --short HEAD` \
        --build-arg VCS_URL=`git config --get remote.origin.url` \
        --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
        $script_dir
