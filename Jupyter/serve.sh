#!/bin/bash

# --rm\

docker run --workdir "/root/documents" \
    --publish "8888:8888" \
    --detach --name "myjupyterlab" \
    --volume "$PWD/documents:/root/documents" \
    --volume "$PWD/install:/root/install" \
    myjupyterlab:1.0
