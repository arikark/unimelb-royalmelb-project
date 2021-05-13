FROM jupyter/scipy-notebook

COPY requirements.txt /etc/jupyterhub/requirements.txt

RUN pip install --upgrade pip && \
    pip install -r /etc/jupyterhub/requirements.txt

RUN pip install --upgrade jupyterlab jupyterlab-git 

RUN jlpm cache clean && \
    jupyter lab clean && \
    jupyter lab build 

RUN mkdir /home/jovyan/work/shared && chown jovyan.users /home/jovyan/work/shared

CMD ["start-singleuser.sh"]

USER jovyan