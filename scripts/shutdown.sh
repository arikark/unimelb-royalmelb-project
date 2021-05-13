#!/bin/bash -v

# this script will bring down all containers on host
docker-compose down
docker stop $(docker ps -aq)