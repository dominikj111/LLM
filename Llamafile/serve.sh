#!/bin/bash

# shellcheck disable=SC1091
# shellcheck disable=SC2034

help_text="\nWill server the model in in the WebUI."
help_flags=(
    "-m, --model          Specify a model file to process (it has to be in ./models folder)"
    "-p, --port           Specify the port to listen on (default: 8080)"
)

# defaults
model="tinyllama-1.1b-chat-v0.3.Q8_0.gguf"
port="8080"

. "$PWD/config.sh"

model_path="./models/$(basename "$model")"

if [ ! -r "$model_path" ] && [ "$model" != "tinyllama-1.1b-chat-v0.3.Q8_0.gguf" ]; then
    red echo "Model file not found: $model_path\n"
    display_help
    exit 1
fi

bgreen echo "Going to serve the model '$model_path' on port '$port' ..."
sleep 5

docker run \
    --interactive \
    --tty \
    --volume "$(pwd)"/scripts:/root/scripts \
    --volume "$(pwd)"/models:/root/models \
    --volume "$(pwd)"/llamafile:/root/llamafile \
    --volume "$(pwd)"/cosmocc:/root/cosmocc \
    --volume "$(pwd)"/output:/root/output \
    --publish "$port":8080 \
    --rm llamafile \
    /bin/bash -c "
        sh ./scripts/entrypoint.sh && 
        llamafile --host 0.0.0.0 -m $model_path
    "
