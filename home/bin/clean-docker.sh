#!/bin/bash
# https://bobcares.com/blog/how-to-clear-docker-cache-and-save-disk-space/

# Delete stopped containers.
docker rm $(docker ps -q -f status=exited)

# Delete untagged images.
docker rmi $(docker images -f "dangling=true" -q)
