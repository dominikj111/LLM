#!/bin/bash

# shellcheck disable=SC1091
# shellcheck disable=SC2034

# help
help_text="\nWill serve the Stable Diffusion WebUI."
help_flags=(
    "-p, --port          Specify the port to listen on (default: 8080)"
)

# defaults
port="8080"

. "$PWD/config.sh"

bgreen echo "Going to serve on port '$port' ..."
sleep 5

docker run \
    --interactive \
    --tty \
    --rm \
    --volume "$(pwd)"/cache/stable-diffusion-webui:/home/sdwui/stable-diffusion-webui \
    --volume "$(pwd)"/dependencies/assets/models/Stable-diffusion:/home/sdwui/stable-diffusion-webui/models/Stable-diffusion \
    --volume "$(pwd)"/dependencies/scripts:/home/sdwui/scripts \
    --volume "$(pwd)"/dependencies/assets:/home/sdwui/sdw-assets \
    --publish "$port":8080 \
    stable-diffusion-webui:1.0
