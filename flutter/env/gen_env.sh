#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Configuration
ROOT_DIR="${SCRIPT_DIR}/../.."
chmod -R +x "${ROOT_DIR}"

# Generate
"${ROOT_DIR}/env/gen_env.sh"
cat <<EOF

ENV_DIR="${SCRIPT_DIR}"

VSCODE_EXTENSIONS_TXT="\${ENV_DIR}/vscode_extensions.txt"
EOF
