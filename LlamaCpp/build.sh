#!/bin/bash

# shellcheck disable=SC1091
# shellcheck disable=SC2034

. ./env.sh

docker build \
    --tag llamacpp \
    --build-arg CENV="$CENV" \
    --build-arg CTZ="$CTZ" \
    --build-arg CLOCALE="$CLOCALE" \
    --build-arg GITEMAIL="$GITEMAIL" \
    --build-arg GITNAME="$GITNAME" \
    .
