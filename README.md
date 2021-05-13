# Overview

This repository contains all of the necessary code in order to run our entire system.

The main components of the system are:

- JuptyerHub
- Backend of the web application (Flask)
- Frontend of the web application (React.js)
- MySQL database

## How to Deploy

### Requirements for Deployment:

- docker
- docker compose

### How to run:

```
.scripts/startup.sh
```

Running this command will spin up 4 containers, containing: the database, jupyterhub, the webapp frontend, and the webapp backend.

To access the webapp frontend

- Go to http://localhost:3000

To access the webapp backend

- Go to http://localhost:5000

To access the JupyterHub

- Go to http://localhost:8000

### How to shutdown:

```
.scripts/shutdown.sh
```
