#!/bin/bash

printf "\nConfim the 'stable-diffusion-webui' repository\n*****\n"

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

printf "\nUpdate the 'stable-diffusion-webui' by local assets\n*****\n"

cp -Rn ./sdw-assets/* ./stable-diffusion-webui
cp ./sdw-assets/webui-user.sh ./stable-diffusion-webui

printf "\nRunning 'stable-diffusion-webui/webui.sh' ...\n*****\n"

cd ./stable-diffusion-webui || exit 1
bash ./webui.sh
