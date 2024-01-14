#!/bin/bash

docker run \
    --interactive \
    --tty \
    --volume "$(pwd)"/scripts:/root/scripts \
    --volume "$(pwd)"/src:/root/src \
    --rm llamacpp \
    /bin/bash ./scripts/entrypoint.sh
