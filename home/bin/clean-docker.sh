#!/bin/bash

# Delete stopped containers.
docker rm $(docker ps -a -q)

# Delete untagged images.
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
