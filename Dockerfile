FROM continuumio/anaconda3:latest

WORKDIR /app

COPY quant_environment.yml .

RUN conda update -n base -c defaults conda && \
    conda env create -n quant-stack --file quant_environment.yml && \
    conda clean -afy

SHELL ["conda", "run", "-n", "quant-stack", "/bin/bash", "-c"]

RUN pip install openbb

RUN conda install -c conda-forge notebook zipline-reloaded pyfolio-reloaded alphalens-reloaded quantstats

RUN pip install -U vectorbt

RUN pip install ibapi

RUN pip install Riskfolio-Lib==3.3.0

RUN conda install -c conda-forge ta-lib

RUN pip install --force-reinstall charset-normalizer==3.1.0

RUN pip install --upgrade requests

RUN pip uninstall -y jupyter_core && pip install jupyter ipykernel

RUN pip install jupyter_copilot

COPY start-jupyter.sh /start-jupyter.sh
RUN chmod +x /start-jupyter.sh

EXPOSE 8888

CMD ["/start-jupyter.sh"]
