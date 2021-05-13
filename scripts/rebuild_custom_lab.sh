#!/bin/bash -v

# Note: all users must be logged out when running this script or else it will fail. This can be done via the admin page.
# TO DO: shutdown and delete user containers.
docker build ./jupyterhub/custom-lab -t custom-lab; 
