#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Generate env file
ENV_DIR="${SCRIPT_DIR}/env"
chmod -R +x "${ENV_DIR}"
"${ENV_DIR}/gen_env.sh" > "${ENV_DIR}/config.env"

# Configuration
. "${ENV_DIR}/config.env"

# Set permissions
chmod -R +x "${ROOT_DIR}"
chmod -R +x "${SCRIPT_DIR}"

# Installation
grep -v '^#' "${ROOT_ENV_VSCODE_EXTENSIONS_TXT}" | xargs -L 1 code --force --install-extension
grep -v '^#' "${VSCODE_EXTENSIONS_TXT}" | xargs -L 1 code --force --install-extension
