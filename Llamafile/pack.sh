#!/bin/bash

docker run \
    --interactive \
    --tty \
    --volume $(pwd)/scripts:/root/scripts \
    --volume $(pwd)/models:/root/models \
    --volume $(pwd)/llamafile:/root/llamafile \
    --volume $(pwd)/cosmocc:/root/cosmocc \
    --volume $(pwd)/output:/root/output \
    --rm llamafile \
    /bin/bash -c "
        sh ./scripts/entrypoint.sh && 
        cd ./output && 
        rm -rf * && 
        cp /usr/local/bin/llamafile-server llava-server.llamafile && 
        zipalign -j0 llava-server.llamafile .args ../models/tinyllama-1.1b-chat-v0.3.Q2_K.gguf
    "
