#!/bin/bash

# shellcheck disable=SC2010
# shellcheck disable=SC2143

printf "\nConfim the 'stable-diffusion-webui' repository\n\n"

if [ -z "$(ls -A ./stable-diffusion-webui)" ]; then
    git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git sdw-repo
    chown -R sdwui:sdwui sdw-repo
    cp -Rn sdw-repo/* ./stable-diffusion-webui
    cp -Rn sdw-repo/.* ./stable-diffusion-webui
    (
        cd ./stable-diffusion-webui && git clean -df && git reset --hard
    )
    rm -rf sdw-repo
else
    (
        cd ./stable-diffusion-webui && git clean -df && git reset --hard && git pull
    )
fi

if [ -z "$(ls -A ./sdw-assets/models/Stable-diffusion | grep -vE '\.(txt|keep)')" ]; then
    printf "\nPull 'v2-1_768-ema-pruned-fp16.ckpt' model from the huggingface repository\n\n"
    (
        cd ./sdw-assets/models/Stable-diffusion &&
            curl -L https://huggingface.co/ckpt/stable-diffusion-2-1/resolve/main/v2-1_768-ema-pruned-fp16.ckpt?download=true -o v2-1_768-ema-pruned-fp16.ckpt
    )
fi

printf "\nUpdate the 'stable-diffusion-webui' by local assets\n\n"

cp -Rn ./sdw-assets/* ./stable-diffusion-webui
cp ./sdw-assets/webui-user.sh ./stable-diffusion-webui

printf "\nRunning 'stable-diffusion-webui/webui.sh' ...\n\n"

cd ./stable-diffusion-webui || exit 1
bash ./webui.sh
