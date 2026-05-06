#!/bin/sh

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

find . -type d -name "build*" -prune -o -name "*.[ch]" -print \
    | xargs clang-format -style=file -i -verbose
