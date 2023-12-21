#!/bin/bash

help_text="The 'run.sh' allows to pass the initial prompt."
help_flags=(
    "-r, --prompt   Specify the initial promt for the model (default: What is the best way to build a robot?)"
)

. "$PWD/config.sh"

if [ ! -n "${prompt+x}" ] || [ -z "$prompt" ]; then
    prompt='What is the best way to build a robot?'
fi

bgreen echo "Going to run the model '$model_path' asking for '$prompt' ..."
sleep 5

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
        llamafile -m $model_path -p $'$prompt'
    "
