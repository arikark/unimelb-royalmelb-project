#!/bin/bash -v

# this script will bring down all containers, and then build the custom-lab container, 
# along with the other containers, finally starting up the service.
docker-compose down
docker build ./jupyterhub/custom-lab -t custom-lab; 
docker-compose build;
docker-compose up;