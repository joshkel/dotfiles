#!/bin/bash

set -e

for f in $(find -name .git); do
    echo $(dirname $f)
    (cd $(dirname $f) && git pull)
done
