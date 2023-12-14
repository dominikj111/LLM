#!/bin/bash

if [ -z "$(ls -A ./cosmocc)" ]; then
    cd ./cosmocc
    curl https://cosmo.zip/pub/cosmocc/cosmocc-3.1.3.zip -o cosmocc-3.1.3.zip
    unzip cosmocc-3.1.3.zip
    rm -rf cosmocc-3.1.3.zip
    cd ..
fi

if [ -z "$(ls -A ./llamafile)" ]; then
    cd ./llamafile
    git clone https://github.com/Mozilla-Ocho/llamafile.git .
    mkdir -p ./cosmocc/3.1.3
    cd ..
else
    cd ./llamafile
    git pull
    cd ..
fi

if [ -z "$(ls -A ./llamafile/cosmocc/3.1.3)" ]; then
    cp -r ./cosmocc/* ./llamafile/cosmocc/3.1.3/
fi

if [ -z "$(ls -A ./models)" ]; then
    cd ./models
    curl -L https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v0.3-GGUF/resolve/main/tinyllama-1.1b-chat-v0.3.Q2_K.gguf -o tinyllama-1.1b-chat-v0.3.Q2_K.gguf
    cd ..
fi

cd ./llamafile
./cosmocc/3.1.3/bin/make -j8
./cosmocc/3.1.3/bin/make install PREFIX=/usr/local
