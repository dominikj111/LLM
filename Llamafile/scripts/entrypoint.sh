#!/bin/bash

# shellcheck disable=SC2086

set -eu pipefail

if [ -z "$(ls -A ./llamafile)" ]; then
    (
        cd ./llamafile &&
            git clone https://github.com/Mozilla-Ocho/llamafile.git .
    )
else
    (
        cd ./llamafile &&
            git pull
    )
fi

COSMOCC_VERSION=$(grep 'COSMOCC = ' ./llamafile/build/config.mk | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')

if [ ! -d "./cosmocc/$COSMOCC_VERSION" ]; then
    (
        cd ./cosmocc && rm -rf ./*
    )
    (
        mkdir -p "./cosmocc/$COSMOCC_VERSION" &&
            cd "./cosmocc/$COSMOCC_VERSION" &&
            curl "https://cosmo.zip/pub/cosmocc/cosmocc-$COSMOCC_VERSION.zip" -o "cosmocc-$COSMOCC_VERSION.zip" &&
            unzip "cosmocc-$COSMOCC_VERSION.zip" &&
            rm -rf "cosmocc-$COSMOCC_VERSION.zip"
    )
fi

if [ ! -d "./llamafile/.cosmocc/$COSMOCC_VERSION" ]; then
    mkdir -p ./llamafile/.cosmocc
    cp -r ./cosmocc/$COSMOCC_VERSION ./llamafile/.cosmocc/$COSMOCC_VERSION
fi

if [ -z "$(ls -A ./models)" ]; then
    (
        cd ./models &&
            curl -L https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v0.3-GGUF/resolve/main/tinyllama-1.1b-chat-v0.3.Q8_0.gguf -o tinyllama-1.1b-chat-v0.3.Q8_0.gguf
    )
fi

cd ./llamafile || exit 1
./.cosmocc/$COSMOCC_VERSION/bin/make -j8
./.cosmocc/$COSMOCC_VERSION/bin/make install PREFIX=/usr/local
