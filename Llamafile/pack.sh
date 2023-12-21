#!/bin/bash

help_text=""
help_flags=()

. "$PWD/config.sh"

bgreen echo "Going to package the model '$model_path' as a llamafile ..."
sleep 5

# Generate .args file
cat << EOF > "./output/.args"
-m
$mode_name
--host
0.0.0.0
EOF

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
        cd ./output && 
        rm -rf * && 
        cp /usr/local/bin/llamafile-server llava-server.llamafile && 
        zipalign -j0 llava-server.llamafile .args .$model_path
    "

rm -rf ./output/.args
