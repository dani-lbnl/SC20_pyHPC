#!/usr/bin/env python3

import coiled
import argparse

# conda=["pip", "nodejs", "graphviz", "compilers"],
coiled.create_software_environment(
    name="sc20-pyhpc",
    conda="environment.yml",
    post_build=["jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib jupyterlab-datawidgets itkwidgets@0.32.0 dask-labextension jupyterlab-plotly@4.10.0 plotlywidget@4.10.0",
                "jupyter serverextension enable dask_labextension"],
)
