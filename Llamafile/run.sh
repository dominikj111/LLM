#!/bin/bash

# shellcheck disable=SC1091
# shellcheck disable=SC2034

help_text="\nWill run the model in CLI without WebUI."
help_flags=(
    "-m, --model           Specify a model file to process (it has to be in ./models folder)"
    "-p, --prompt          Specify the initial promt for the model (default: What is the best way to build a robot?)"
)

# defaults
model="tinyllama-1.1b-chat-v0.3.Q8_0.gguf"
prompt="What is the best way to build a robot?"

. "$PWD/config.sh"

model_path="./models/$(basename "$model")"

if [ ! -r "$model_path" ] && [ "$model" != "tinyllama-1.1b-chat-v0.3.Q8_0.gguf" ]; then
    red echo "Model file not found: $model_path\n"
    display_help
    exit 1
fi

bgreen echo "Going to run the model '$model_path' asking for '$prompt' ..."
sleep 5

docker run \
    --interactive \
    --tty \
    --volume "$(pwd)"/scripts:/root/scripts \
    --volume "$(pwd)"/models:/root/models \
    --volume "$(pwd)"/llamafile:/root/llamafile \
    --volume "$(pwd)"/cosmocc:/root/cosmocc \
    --volume "$(pwd)"/output:/root/output \
    --rm llamafile \
    /bin/bash -c "
        sh ./scripts/entrypoint.sh && 
        llamafile -m $model_path -p $'$prompt'
    "
