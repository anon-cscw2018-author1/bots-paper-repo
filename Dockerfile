FROM andrewosh/binder-base

USER root

ADD requirements.txt requirements.txt
ADD handle-requirements.py handle-requirements.py
RUN python handle-requirements.py

RUN apt-get update && \
    apt-get install -y python-dev curl gcc g++ && \
    curl https://bootstrap.pypa.io/get-pip.py | python && \
    pip install ipython[notebook]
    
RUN conda config --add channels r && \
    conda install --quiet --yes \
    'rpy2=2.8*' \
    'r-base=3.3.1 1' \
    'r-irkernel=0.6*' \
    'r-devtools=1.11*' \
    'r-ggplot2=2.1*' \
    'r-rcurl=1.95*' \
    'r-data.table=1.10.0*' && conda clean -tipsy

USER main
WORKDIR $HOME/notebooks
