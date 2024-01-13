#!/bin/bash

# shellcheck disable=SC1091
. ./env.sh

docker build \
    --tag stable-diffusion-webui:1.0 \
    --build-arg CENV="$CENV" \
    --build-arg CTZ="$CTZ" \
    --build-arg CLOCALE="$CLOCALE" \
    --build-arg GITEMAIL="$GITEMAIL" \
    --build-arg GITNAME="$GITNAME" \
    .
