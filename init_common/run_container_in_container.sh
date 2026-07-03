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
INSTALL_TXT="${ENV_DIR}/install.txt"

${TOOLS_DIR}/utils/concat_files.sh \
    --files \
    ${ROOT_DIR}/init/env/install/run_container_in_container.txt \
    > "${INSTALL_TXT}"

# ==================================================
# Install
grep -v '^#' "${INSTALL_TXT}" \
    | xargs "${TOOLS_DIR}/utils/install_cross_platform.sh"
