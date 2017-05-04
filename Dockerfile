FROM andrewosh/binder-base:latest

RUN mkdir /home/main/notebooks
RUN chown main:main /home/main/notebooks
WORKDIR /home/main/notebooks
USER root
COPY . /home/main/notebooks/
RUN chown -R main:main $HOME/notebooks
USER main

RUN find $HOME/notebooks -name '*.ipynb' -exec jupyter trust {} \;

ADD requirements.txt requirements.txt
ADD handle-requirements.py handle-requirements.py
RUN python handle-requirements.py

RUN apt-get update && \
    apt-get install -y python-dev curl gcc g++ && \
    curl https://bootstrap.pypa.io/get-pip.py | python && \
    pip install ipython[notebook]

RUN apt-get install -y libzmq3-dev libcurl4-openssl-dev && \
    (echo "install.packages(c('rzmq','repr','IRkernel','IRdisplay', 'ggplot2', 'data.table')," && \
     echo "    repos = c('http://irkernel.github.io/', getOption('repos')))" && \
     echo "IRkernel::installspec()") \
    | Rscript -e "source(file('stdin'))" && \
    mkdir -p workspace/notebooks workspace/data /root/.ipython/profile_default

USER main
WORKDIR $HOME/notebooks
