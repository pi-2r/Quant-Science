# Quant Stack Project
This repository contains a quantitative analysis environment setup for data science and machine learning projects. The project includes configuration files for creating a consistent development environment and running Jupyter Lab.
This stack is used for courses of https://quantscience.io/.

## Environment Setup
The project uses Conda for managing the Python environment. The quant_environment.yml file specifies the required dependencies:

```sh
name: quant-stack
channels:
  - conda-forge
  - defaults
dependencies:
  - python=3.9.13
  - git
  - pip
  - pybind11
  - cmake
  - openssl=1.1.1
  - libtiff
  - numpy==1.23.4
  - ffmpeg
  - lightgbm==3.3.5
  - cvxpy==1.2.2
  - pip:
    - poetry==1.4.0
    - charset-normalizer==3.1.0
    - catboost==1.1.1
    - xgboost==1.7.4
    - qdldl==0.1.5.post3
```
To create the environment, run:

```sh
conda env create -f quant_environment.yml
```

## Starting Jupyter Lab
The project includes a bash script start-jupyter.sh to launch Jupyter Lab:

```sh
#!/bin/bash

source activate quant-stack

jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.password="$JUPYTER_PASSWORD"
```


To start Jupyter Lab:

- Ensure you have set the JUPYTER_PASSWORD environment variable.
- Make the script executable: chmod +x start-jupyter.sh
-  Run the script: ./start-jupyter.sh

Jupyter Lab will start on port 8888, accessible from any IP address, and will require the password set in the JUPYTER_PASSWORD environment variable.

## Additional Files
The repository also includes a Dockerfile and a Makefile, which may contain additional configuration for containerization and build processes.

## Getting Started

-  Clone this repository
-  Set the JUPYTER_PASSWORD environment variable in the makefile
-  Run the command: **make build** and **make run**
-  Access Jupyter Lab through your web browser at http://localhost:8888
-  Enter the password set in the JUPYTER_PASSWORD environment variable