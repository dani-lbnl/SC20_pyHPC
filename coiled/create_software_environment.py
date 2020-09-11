#!/usr/bin/env python3

import coiled
import argparse

# conda=["pip", "nodejs", "graphviz", "compilers"],
coiled.create_software_environment(
    name="sc20-pyhpc",
    conda="environment.yml",
    post_build=["jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib jupyterlab-datawidgets itkwidgets@0.32.0 dask-labextension",
                "jupyter serverextension enable dask_labextension"],
)
