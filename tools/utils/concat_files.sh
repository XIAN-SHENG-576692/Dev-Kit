#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

usage() {
    echo "Usage: $0 [OPTION]..."
    echo ""
    echo "Options:"
    echo "  -h, --help"
    echo "      Print help"
    echo ""
    echo "  -f, --files [FILE_0 FILE_1 ...]"
    echo "      Concatenate the contents of the files, and then remove duplicate lines."
    exit 1
}

if [ "$#" -eq 0 ]; then
    usage
fi

# Configuration
ROOT_DIR=$(cd "${SCRIPT_DIR}/../.."; pwd)
ENV_DIR="${ROOT_DIR}/env"
ENV_FILE="${ENV_DIR}/.env"

# Configuration Load
source "${ENV_FILE}"

FILE_ARRAY=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            usage
            ;;
        -f|--files)
            shift
            # Loop until the next argument is an option or we run out of arguments
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                FILE_ARRAY+=("$1")
                shift
            done
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

FILE_ITEMS=()
for item in "${FILE_ARRAY[@]}"; do
    mapfile -t -O "${#FILE_ITEMS[@]}" FILE_ITEMS < <(grep -Ev '^#|^$' "${item}")
done
mapfile -t UNIQUE_ITEMS < <(printf "%s\n" "${FILE_ITEMS[@]}" | awk '!x[$0]++')
printf "%s\n" "${UNIQUE_ITEMS[@]}"
