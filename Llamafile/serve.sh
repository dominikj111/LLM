#!/bin/bash

help_text=""
help_flags=(
    "-p, --port     Specify the port to listen on (default: 8080)"
)

. "$PWD/config.sh"

if [ ! -n "${port+x}" ] || [ -z "$port" ]; then
    port="8080"
fi

bgreen echo "Going to serve the model '$model_path' on port '$port' ..."
sleep 5

docker run \
    --interactive \
    --tty \
    --volume $(pwd)/scripts:/root/scripts \
    --volume $(pwd)/models:/root/models \
    --volume $(pwd)/llamafile:/root/llamafile \
    --volume $(pwd)/cosmocc:/root/cosmocc \
    --volume $(pwd)/output:/root/output \
    --publish $port:8080 \
    --rm llamafile \
    /bin/bash -c "
        sh ./scripts/entrypoint.sh && 
        llamafile-server --host 0.0.0.0 -m $model_path
    "
