FROM jupyterhub/jupyterhub:1.2

RUN pip3 install dockerspawner 

RUN pip3 install jupyterhub-nativeauthenticator 

COPY jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py

CMD jupyterhub -f /srv/jupyterhub/jupyterhub_config.py