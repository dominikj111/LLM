#!/bin/bash

source ./env.sh

docker build \
    --tag debian:python \
    --build-arg CENV=$CENV \
    --build-arg CTZ=$CTZ \
    --build-arg CLOCALE=$CLOCALE \
    --build-arg GITEMAIL=$GITEMAIL \
    --build-arg GITNAME=$GITNAME \
    .
