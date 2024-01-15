#!/bin/bash

# shellcheck disable=SC1091
# shellcheck disable=SC2034

help_text="\nWill pack the model and runtime into executable file."
help_flags=(
    "-m, --model           Specify a model file to process (it has to be in ./models folder)"
)

# defaults
model="tinyllama-1.1b-chat-v0.3.Q8_0.gguf"

. "$PWD/config.sh"

model="$(basename "$model")"
model_path="./models/$model"

if [ ! -r "$model_path" ] && [ "$model" != "tinyllama-1.1b-chat-v0.3.Q8_0.gguf" ]; then
    red echo "Model file not found: $model_path\n"
    display_help
    exit 1
fi

bgreen echo "Going to package the model '$model_path' as a llamafile ..."
sleep 5

# Remove previous generated files
rm -rf ./output/*

# Generate/overwrite the .args file
cat <<EOF >"./output/.args"
--model
$model
--server
--host
0.0.0.0
...
EOF

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
        cd ./output &&
        cp /usr/local/bin/llamafile llava-server.llamafile &&
        zipalign -j0 llava-server.llamafile .args .$model_path
    "
