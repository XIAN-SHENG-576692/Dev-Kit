#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Configuration
INPUT_DIR=$1

cd "${INPUT_DIR}" || {
    echo "Error: Unable to access ${INPUT_DIR}"
    exit 1
}

find . \
    -type f \
    -name "*.typ" \
    -print \
    -exec typstyle \
        -i \
        -t 4 \
        --column 80 \
        --wrap-text \
        {} +
