#!/bin/bash
source activate quant-stack

# Creation of the directory for JupyterLab settings
mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension

# Setting default dark theme
cat << EOF > /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings
{
    "theme": "JupyterLab Dark"
}
EOF

jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.password="$JUPYTER_PASSWORD"
