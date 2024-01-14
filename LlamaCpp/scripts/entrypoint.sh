#!/bin/bash

set -eu pipefail

if [ -z "$(ls -A ./src)" ]; then
    (
        cd ./src &&
            git clone https://github.com/ggerganov/llama.cpp.git .
    )
else
    (
        cd ./src &&
            git pull
    )
fi

(cd ./src && make)
