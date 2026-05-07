#!/bin/bash

# Configuration
SCRIPT_DIR=$(cd $(dirname $0); pwd)
. "$SCRIPT_DIR/env/config.env"

source "${PYTHON_VENV_ACTIVATE}"

python3 "${SCRIPT_DIR}/gen_iter_files.py" $@

deactivate
