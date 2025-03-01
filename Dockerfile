FROM continuumio/anaconda3:latest

WORKDIR /app

COPY quant_environment.yml .
# Modifiez le fichier quant_environment.yml pour retirer poetry
RUN sed -i '/poetry==1.4.0/d' quant_environment.yml

# Assurez-vous d'avoir les dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    build-essential \
    llvm-dev \
    gcc \
    g++ \
    gfortran \
    libatlas-base-dev

RUN conda update -n base -c defaults conda && \
    conda env create -n quant-stack --file quant_environment.yml && \
    conda clean -afy

SHELL ["conda", "run", "-n", "quant-stack", "/bin/bash", "-c"]

# Installez poetry séparément avec une contrainte sur cachecontrol
RUN pip install "cachecontrol>=0.12.9,<0.13.0" && \
    pip install poetry==1.4.0

# Installez les packages manquants dans l'environnement
RUN conda install -c conda-forge \
    pandas \
    scipy \
    statsmodels \
    scikit-learn \
    quantlib \
    ta-lib \
    notebook \
    zipline-reloaded \
    pyfolio-reloaded \
    alphalens-reloaded \
    quantstats \
    logbook \
    -y

# Installez numba explicitement avant riskfolio
RUN pip install --no-cache-dir numba
RUN pip install --no-cache-dir riskfolio-lib

# Autres packages via pip
RUN pip install "openbb[all]" --no-cache-dir && \
    pip install -U vectorbt && \
    pip install ibapi && \
    pip install --force-reinstall charset-normalizer==3.1.0 && \
    pip install --upgrade requests && \
    pip uninstall -y jupyter_core && \
    pip install jupyter ipykernel && \
    pip install jupyter_copilot && \
    pip install QuantLib

COPY start-jupyter.sh /start-jupyter.sh
RUN chmod +x /start-jupyter.sh

EXPOSE 8888

CMD ["/start-jupyter.sh"]
