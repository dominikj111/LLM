#!/bin/bash

# help_text=""
# help_flags=(
#     "-p, --port     Specify the port to listen on (default: 8080)"
# )

# . "$PWD/config.sh"

# if [ ! -n "${port+x}" ] || [ -z "$port" ]; then
#     port="8080"
# fi

# bgreen echo "Going to serve on port '$port' ..."
# sleep 5

docker run \
    --interactive \
    --tty \
    --volume "$(pwd)"/cache/stable-diffusion-webui:/home/sdwui/stable-diffusion-webui \
    --volume "$(pwd)"/dependencies/stable-diffusion-webui/models/Stable-diffusion:/home/sdwui/stable-diffusion-webui/models/Stable-diffusion \
    --volume "$(pwd)"/dependencies/scripts:/home/sdwui/scripts \
    --volume "$(pwd)"/dependencies/stable-diffusion-webui:/home/sdwui/sdw-assets \
    --publish 8080:8080 \
    --rm debian:python
