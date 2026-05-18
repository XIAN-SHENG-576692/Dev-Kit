#!/bin/bash

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

DIRS=""

for dir in $(find ${PWD} -type d -name "pubspec.yaml"); do
    DIRS+="${dir}/../lib "
    [ -d "/path/to/dir" ] && DIRS+="${dir}/../test "
done
dart format ${DIRS}
