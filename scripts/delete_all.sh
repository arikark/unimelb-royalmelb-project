#!/bin/bash -v

# this script will bring down all containers, delete them along with networks and volumes
docker-compose down
docker stop $(docker ps -aq)
docker rm $(docker ps -a -q)
docker volume rm $(docker volume ls -q)
docker network prune -f

