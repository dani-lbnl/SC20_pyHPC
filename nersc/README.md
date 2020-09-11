# NERSC Dask-JupyterLab sc20-pyhpc setup

Scripts to automatically set up a user's account on the [NERSC
JupyterHub](https://docs.nersc.gov/services/jupyter/) with:

- A Dask cluster running on NERSC Cori for parallel computation
- itkwidgets for 3D Jupyter-native visualization
- Python packages for 3D material image analysis

This setup ensures a consistent software environment for:

- The JupyterLab server and client
- The Jupyter kernel Python process
- The Dask dashboard
- The Dask scheduler
- The Dask workers

## Setting up Dask for distributed computing with the pyhpc environment on NERSC

### Step 0: Install for sc20-pyhpc-nersc-dask the Jupyter Kernel

This step only needs to performed once.

In order for JupyterHub to run our version of JupyterLab with our JupyterLab
extensions,  we will override the JupyterLab launched by JupyterHub.
This will also to provide our Python compute environment for the Jupyter
Python kernel. The Jupyter *kernel* is the server-side compute environment where
Jupyter executes code.

In a terminal on Cori, either via JupyterLab or SSH, run:

```sh
cd SC20_pyHPC/nersc
bash ./install-override-jupyter.sh
```

This will override the JupyterLab version launched when you start a server at
[NERSC JupyterHub](https://docs.nersc.gov/services/jupyter/).

Go to *jupyter.nersc.gov*; shutdown any running NERSC JupyterLab servers, and
start up the a NERSC JupyterLab server.

As a result, when you start Jupyter on Cori this way the default Python 3
kernel is also providing the

  **sc20-pyhpc-nersc-dask**

software environment environment, i.e. scientific Python packages.
This Python computing environment is running in a
[Docker / Shifter image](https://docs.nersc.gov/development/shifter/overview/)
with Python, MPI, Dask, dask-image, itk, etc. installed and configured for NERSC.

To revert to the default NERSC Cori JupyterLab:

```sh
rm ~/.override-jupyter
```


### Step 1: Start up the Dask cluster

On Cori, we can start up a Dask the cluster with the `start-dask-mpi` script
developed by Rollin Thomas at NERSC. This script has to be executed within the
*$SCRATCH* directory. It can be made available by loading the *nersc-dask*
module.

```sh
cd $SCRATCH
module load nersc-dask
start-dask-mpi --ntasks=100 --image=thewtex/sc20-pyhpc-nersc-dask:latest
```

The *--image=* argument specifies the same computing environment, i.e. Python
version Python packages, etc. as the Jupyter kernel.

Wait for the job to start (you may need to re-run the command if the interactive queue is really busy).
There will be a lot of output from the cluster when it starts up.

This will start a Dask scheduler for the cluster and workers. The
configuration for cluster is located in the *scheduler.json* file where
`start-dask-mpi` was executed. For the above, this is at *$SCRATCH/scheduler.json*.

### Step 2: Connect to the Dask cluster

Finally, tell your  notebook to connect to the Dask cluster scheduler.

In the above example, we created the scheduler configuration file at `$SCRATCH/scheduler.json`. We need to connect to the cluster,
and we should also set up a link to the Dask dashboard.
This is optional but the dashboard is extremely helpful for understanding your cluster its real-time workload.

```python
import os

import dask
from dask.distributed import Client

scheduler_file = os.path.join(os.environ["SCRATCH"], "scheduler.json")
dask.config.config["distributed"]["dashboard"]["link"] = "{JUPYTERHUB_SERVICE_PREFIX}proxy/{host}:{port}/status"
```

The client is an object that manages communication with your cluster.
Initialize a client by passing it the path to the scheduler file.

```python
client = Client(scheduler_file=scheduler_file)
client
```

Printing the client object results in a widget with some information in it.
Click the dashboard link, which will start up another tab with the dashboard in it.

Dask tasks, created with calls to functions on `client`, functions on
`dask.Array`'s or functions on Dask Array-backed `xarray.DataArray`'s will run
on the cluster's workers.
