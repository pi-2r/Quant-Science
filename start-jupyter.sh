#!/bin/bash
source activate quant-stack
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.password="$JUPYTER_PASSWORD"
