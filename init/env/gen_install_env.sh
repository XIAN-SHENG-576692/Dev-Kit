#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

usage() {
    echo "Usage: $0 [OPTION]..."
    echo ""
    echo "Options:"
    echo "  -c, --cargo, --cargo-install [FILE_0 FILE_1 ...]"
    echo "  -h, --help"
    echo "  -i, --in, --install [FILE_0 FILE_1 ...]"
    echo "  -n, --npm, --npm-install [FILE_0 FILE_1 ...]"
    echo "  -p, --python, --python-requirements [FILE_0 FILE_1 ...]"
    echo "  -v, --vs, --vscode-extensions [FILE_0 FILE_1 ...]"
    exit 1
}

if [ "$#" -eq 0 ]; then
    usage
fi

# Configuration
ROOT_DIR=$(cd "${SCRIPT_DIR}/../.."; pwd)
ENV_DIR="${ROOT_DIR}/env"
ENV_FILE="${ENV_DIR}/.env"

# Configuration Load
source "${ENV_FILE}"
source "${TOOLS_DIR}/utils/join_by_string.sh"

while [[ $# -gt 0 ]]; do
    case "$1" in
        -c|--cargo|--cargo-install)
            FILE="${CARGO_INSTALL_TXT}"
            ;;
        -h|--help)
            usage
            ;;
        -i|--in|--install)
            FILE="${INSTALL_TXT}"
            ;;
        -n|--npm|--npm-install)
            FILE="${NPM_INSTALL_TXT}"
            ;;
        -p|--python|python-requirements)
            FILE="${PYTHON_REQUIREMENTS_TXT}"
            ;;
        -v|--vs|--vscode-extensions)
            FILE="${VSCODE_EXTENSIONS_TXT}"
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
    FILE_ARRAY=()
    shift
    # Loop until the next argument is an option or we run out of arguments
    while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
        FILE_ARRAY+=("$1")
        shift
    done
    FILE_ITEMS=()
    for item in ${FILE_ARRAY[@]}; do
        mapfile -t -O "${#FILE_ITEMS[@]}" FILE_ITEMS < <(grep -Ev '^#|^$' "${item}")
    done
    FILE_ITEMS=($(printf "%s\n" "${FILE_ITEMS[@]}" | awk '!x[$0]++'))
    FILE_CONTEXT=$(join_by_string "\n" "${FILE_ITEMS[@]}")
    echo -e ${FILE_CONTEXT} > "${FILE}"
done
