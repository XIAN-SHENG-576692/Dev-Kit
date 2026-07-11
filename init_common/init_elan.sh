#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# ==================================================
# Configuration
ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)

# ==================================================
# Init
${ROOT_DIR}/init/env/gen_env.sh

# Configuration Load
ENV_DIR="${ROOT_DIR}/env"
ENV_FILE="${ENV_DIR}/.env"
source "${ENV_FILE}"

# ==================================================
# Generate install list files
VSCODE_EXTENSIONS_TXT="${ENV_DIR}/vscode_extensions.txt"

${TOOLS_DIR}/utils/concat_files.sh \
    --files \
    ${ROOT_DIR}/init/env/vscode_extensions/lean4.txt \
    > "${VSCODE_EXTENSIONS_TXT}"

# ==================================================
# Install
"${ROOT_DIR}/init/others/elan-init.sh"
source "${ROOT_DIR}/init/others/export_elan_env.sh"

# Install VS Code extensions
grep -v '^#' "${VSCODE_EXTENSIONS_TXT}" | grep -v '^$' | while read -r line; do
    code --force --install-extension $line
done
