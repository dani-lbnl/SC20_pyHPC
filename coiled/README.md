# Coiled.io Dask-JupyterLab sc20-pyhpc setup

[Coiled](https://docs.coiled.io/) is a deployment-as-a-service library for
scaling Python with [Dask](https://dask.org) clusters.

## Install and setup

To work with a Coiled cluster, first install the *coiled* Python package:

```sh
pip install coiled
```

```sh
conda install -c conda-forge coiled
```

Then, login:

```sh
coiled login
```

## Install the Coiled software environment locally

# Create local version of the coiled/default software environment
Installation and activation of the *sc20-pyhpc* software environment locally
requires [conda](https://docs.conda.io/en/latest/). To install and activate
the environment:

```sh
coiled install thewtex/sc20-pyhpc
conda activate coiled-thewtex-sc20-pyhpc
jupyter lab
```

## Optional: Building the Coiled software environment

To change the packages available in the software environment, the coiled
software environment can be customized an re-built. This required a
[Docker](https://www.docker.com) installation.

First, install the *coiled* Python package, then
customize the packages in the *requirements.txt* file, then run:

```
python ./coiled/create_software_environment.py
```

For more information, see the script and [associated
documentation](https://docs.coiled.io/user_guide/software_environment.html).
