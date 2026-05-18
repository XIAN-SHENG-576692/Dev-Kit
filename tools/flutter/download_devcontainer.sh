#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Configuration
INPUT_DIR=$1

# Install container
git clone --filter=tree:0 --depth=1 --no-tags \
    https://github.com/XIAN-SHENG-576692/Flutter-Dev-Container.git \
    ${INPUT_DIR}
