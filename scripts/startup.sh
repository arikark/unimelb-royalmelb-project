#!/bin/bash -v

docker build ./jupyterhub/custom-lab -t custom-lab; 
docker-compose build;
docker-compose up;