#!/bin/bash

set -euo pipefail

script_name=$(basename "$0")

bgreen() {
    printf "\e[1m\e[32m"
    "$@"
    printf "\e[0m"
}

red() {
    printf "\e[31m"
    "$@"
    printf "\e[0m"
}

display_help() {
    echo "Usage: ./$script_name [OPTIONS]"

    if [ -n "$help_text" ]; then
        echo "$help_text"
    fi

    echo ""
    echo "Options:"
    echo "-h, --help          Display this help message"

    # shellcheck disable=SC2154
    if [ ${#help_flags[@]} -ne 0 ]; then
        for help_flag in "${help_flags[@]}"; do
            echo "$help_flag"
        done
    fi

    echo ""
}

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
    -h | --help)
        display_help
        exit 0
        ;;
    *)
        # Test if the flag is strictly short or long
        if [[ "$key" =~ ^--[[:lower:]][[:lower:]]+$ ]]; then
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
                long_flag_name=""
                short_flag_name=""

                # Extract long flag name from the flag description
                if [[ "${help_flag}" =~ -[[:lower:]],[[:space:]]--([[:lower:]][[:lower:]]+)[[:space:]].+ ]]; then
                    long_flag_name="${BASH_REMATCH[1]}"
                fi

                # Extract short flag name from the flag description
                if [[ "${help_flag}" =~ -([[:lower:]]),[[:space:]]--[[:lower:]][[:lower:]]+[[:space:]].+ ]]; then
                    short_flag_name="${BASH_REMATCH[1]}"
                fi

                if [[ "$key" == "--$long_flag_name" ]] || [[ "$key" == "-$short_flag_name" ]]; then
                    flag_name="$long_flag_name"
                fi

                break
            fi
        done

        if [ -n "$flag_name" ] && [ -n "${2+x}" ] && [ -n "$2" ]; then
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
