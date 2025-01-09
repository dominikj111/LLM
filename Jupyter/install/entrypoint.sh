#!/bin/bash

set -eu pipefail

########################
# Check/Install NodeJS #
########################

printf "Checking/Installing NodeJS...\n"

if ! which n; then
    (
        cd /root/install
        # shellcheck disable=SC2010
        if ! ls | grep -q ^n$; then
            (
                curl -fsSL https://raw.githubusercontent.com/tj/n/v10.0.0/bin/n -o n
            )
        fi
        bash -s lts <n
        npm install -g n
    )
fi

############################
# Check/Install JupyterLab #
############################

printf "Checking/Installing JupyterLab...\n"


if ! which conda; then
    (
        cd /root/install
        # shellcheck disable=SC2010
        if ! ls | grep -q ^Miniconda3-latest-Linux-aarch64.sh$; then
            (
                wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh
            )
        fi
        if ! (test -d "/opt/miniconda3" && test "$(ls -A /opt/miniconda3)"); then
            # Miniconda 3 installation
            bash Miniconda3-latest-Linux-aarch64.sh -b -p /opt/miniconda3
            if ! grep conda.sh /root/.bashrc; then
                (
                    # Miniconda 3 activation
                    echo ". /opt/miniconda3/etc/profile.d/conda.sh" >>/root/.bashrc
                    echo "conda activate base" >>/root/.bashrc
                )
            fi
        fi
        # shellcheck disable=SC1091
        . /root/.bashrc
        # Jupyter, JupyterLab installation
        conda install -c conda-forge jupyter jupyterlab -y
    )
fi

######################
# Check/Install Rust #
######################

# https://racum.blog/articles/rust-jupyter/
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# rustup component add rust-src
# cargo install --locked evcxr_jupyter
# evcxr_jupyter --install

# Add also the JS/TS kernel


# Set the port number (default is 8888)
PORT=8888

# Set the notebook directory (default is current directory)
NOTEBOOK_DIR=$(pwd)

# Run the Jupyter server
/opt/miniconda3/bin/jupyter lab --port "$PORT" --notebook-dir "$NOTEBOOK_DIR" --allow-root --ip='*' --no-browser --NotebookApp.token='' --NotebookApp.password=''
