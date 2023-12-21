#!/bin/bash

docker run \
    --interactive \
    --tty \
    --volume $(pwd)/scripts:/root/scripts \
    --volume $(pwd)/models:/root/models \
    --volume $(pwd)/llamafile:/root/llamafile \
    --volume $(pwd)/cosmocc:/root/cosmocc \
    --volume $(pwd)/output:/root/output \
    --publish 8080:8080 \
    --rm llamafile \
    /bin/bash -c "
        sh ./scripts/entrypoint.sh && 
        llamafile-server --host 0.0.0.0 -m ./models/tinyllama-1.1b-chat-v0.3.Q8_0.gguf
    "
  