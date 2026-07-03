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
CARGO_INSTALL_TXT="${ENV_DIR}/cargo_install.txt"
INSTALL_TXT="${ENV_DIR}/install.txt"
VSCODE_EXTENSIONS_TXT="${ENV_DIR}/vscode_extensions.txt"

${TOOLS_DIR}/utils/concat_files.sh \
    --files \
    ${ROOT_DIR}/init/env/cargo/dev_typst_on_host.txt \
    > "${CARGO_INSTALL_TXT}"

${TOOLS_DIR}/utils/concat_files.sh \
    --files \
    ${ROOT_DIR}/init/env/install/common.txt \
    ${ROOT_DIR}/init/env/install/dev_typst_on_host.txt \
    > "${INSTALL_TXT}"

${TOOLS_DIR}/utils/concat_files.sh \
    --files \
    ${ROOT_DIR}/init/env/vscode_extensions/common.txt \
    ${ROOT_DIR}/init/env/vscode_extensions/dev_typst.txt \
    > "${VSCODE_EXTENSIONS_TXT}"

# ==================================================
# Install
grep -v '^#' "${INSTALL_TXT}" \
    | xargs "${TOOLS_DIR}/utils/install_cross_platform.sh"

# Install Cargo
rustup default stable
source ${ROOT_DIR}/init/others/export_cargo_env.sh
grep -v '^#' "${CARGO_INSTALL_TXT}" | grep -v '^$' | while read -r line; do
    $line
done

# Install VS Code extensions
grep -v '^#' "${VSCODE_EXTENSIONS_TXT}" | grep -v '^$' | while read -r line; do
    code --force --install-extension $line
done
