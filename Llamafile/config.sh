#!/bin/bash

set -euo pipefail

script_name=$(basename "$0")

bgreen() {
    printf "\e[1m\e[32m"
    $@
    printf "\e[0m"
}

red() {
    printf "\e[31m"
    $@
    printf "\e[0m"
}

display_help() {
    echo "Usage: ./$script_name [OPTIONS]"

    if [ ! -z "$help_text" ]; then
        echo "$help_text"
    fi

    echo ""
    echo "Options:"
    echo "-h, --help     Display this help message"
    echo "-m, --model    Specify a model file to process (it has to be in ./models folder)"

    if [ ${#help_flags[@]} -ne 0 ]; then
        for help_flag in "${help_flags[@]}"; do
            echo "$help_flag"
        done

    fi

    echo ""
}

mode_name=""
model_path=""

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
    -h | --help)
        display_help
        exit 0
        ;;
    -m | --model)
        mode_name=$(basename "$2")
        shift
        shift
        ;;
    *)
        # Test if the flag is strictly short or long
        if [[ "$key" =~ ^--[[:lower:]]+$ ]]; then
            # nothing todo
            :
        elif [[ "$key" =~ ^-[[:lower:]]$ ]]; then
            # nothing todo
            :
        else
            red echo "Unknown option: $1\n"
            display_help
            exit 1
        fi

        flag_name=""
        # Loop through the external flag source
        for help_flag in "${help_flags[@]}"; do

            # Check if the flag is in the external flag source
            if [[ "${help_flag}" == *"$1"* ]]; then

                # Extract the flag name from the flag description
                if [[ "${help_flag}" =~ -[[:lower:]],[[:space:]]--([[:lower:]]+)[[:space:]].+ ]]; then
                    flag_name="${BASH_REMATCH[1]}"
                fi
                break
            fi
        done

        if [ ! -z $flag_name ] && [ -n "${2+x}" ] && [ ! -z "$2" ]; then
            flag_value="$2"
            eval "${flag_name}='${flag_value}'"
            shift
            shift
            continue
        else
            red echo "Unknown option: $1\n"
            display_help
            exit 1

        fi
        ;;
    esac
done

if [ -z "$mode_name" ]; then
    mode_name="tinyllama-1.1b-chat-v0.3.Q8_0.gguf"
fi

model_path="./models/$mode_name"

if [ ! -r "$model_path" ]; then
    red echo "Model file not found: $model_path\n"
    display_help
    exit 1
fi
