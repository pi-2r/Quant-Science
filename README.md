# Quant Stack Project

<img src="img/python_quant_stack.png">

This repository contains a quantitative analysis environment setup for data science and machine learning projects. The project includes configuration files for creating a consistent development environment and running Jupyter Lab.
This stack is used for courses of https://quantscience.io/.

## Prerequisites

    Docker

    Make (optional, for using the provided makefile commands)

## Quick Start

Clone this repository:

```sh
git clone https://github.com/pi-2r/Quant-Science.git
cd Quant-Science
```
Build the Docker image:
```sh
make build
```
Run the container:
```sh
make run
```
By default, the Jupyter password is set to "password". You can customize it by running:

```sh
make run JUPYTER_PASSWORD=your_custom_password
```

Access JupyterLab in your browser at: [http://localhost:8888](http://localhost:8888)

## Environment Details

This environment is built on Anaconda with Python 3.9.13 and includes the following key libraries:

Core Libraries

    NumPy 1.23.4

    Pandas

    SciPy

    StatsModels

    scikit-learn

Financial Libraries

    OpenBB

    QuantLib

    riskfolio-lib

    vectorbt

    ta-lib

    zipline-reloaded

    pyfolio-reloaded

    alphalens-reloaded

    quantstats

    Interactive Brokers API (ibapi)

Machine Learning

    LightGBM 3.3.5

    CatBoost 1.1.1

    XGBoost 1.7.4

Optimization

    CVXPY 1.2.2

## Available Commands

The makefile provides several convenient commands:

    make build: Build the Docker image

    make run: Start the container with JupyterLab

    make stop: Stop and remove the running container

    make clean: Remove the Docker image

    make logs: Display container logs

    make shell: Open a shell inside the container

    make help: Display available commands

## Customization

You can customize the environment by modifying:

    quant_environment.yml: Add or modify conda and pip packages

    Dockerfile: Change the base image or add system dependencies

## Troubleshooting

If you encounter dependency conflicts during the build process, try:

    Updating the charset-normalizer version to >=3.4.0 in the quant_environment.yml file

    Ensuring compatible versions between packages
