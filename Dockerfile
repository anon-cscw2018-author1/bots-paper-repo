FROM andrewosh/binder-base

USER root

ADD requirements.txt requirements.txt
ADD handle-requirements.py handle-requirements.py
RUN python handle-requirements.py

RUN apt-get update && \
    apt-get install -y python-dev curl gcc g++ && \
    curl https://bootstrap.pypa.io/get-pip.py | python && \
    pip install ipython[notebook]
    
RUN apt-get install -y libzmq3-dev libcurl4-openssl-dev && \
    (echo "install.packages(c('rzmq','repr','IRkernel','IRdisplay', 'ggplot2', 'data.table'), \
    repos='http://cran.us.r-project.org')" && \
    echo "IRkernel::installspec()") | R --no-save && \
    mkdir -p workspace/notebooks workspace/data /root/.ipython/profile_default

USER main
WORKDIR $HOME/notebooks
