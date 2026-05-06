#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Generate env file
ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)

# Output
cat <<EOF
ROOT_DIR="${ROOT_DIR}"
ROOT_ENV_DIR="${SCRIPT_DIR}"
ROOT_ENV_INSTALL_TXT="\${ROOT_ENV_DIR}/install.txt"
ROOT_ENV_VSCODE_EXTENSIONS_TXT="\${ROOT_ENV_DIR}/vscode_extensions.txt"
EOF
