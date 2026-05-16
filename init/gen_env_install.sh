#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

usage() {
    echo "Usage: $0 [OPTION]..."
    echo ""
    echo "Options:"
    echo "  -h, --help"
    echo "  -i, --in, --install [FILE_0 FILE_1 ...]"
    echo "  -p, --python, --python-requirements [FILE_0 FILE_1 ...]"
    echo "  -v, --vs, --vscode-extensions [FILE_0 FILE_1 ...]"
    exit 1
}

if [ "$#" -eq 0 ]; then
    usage
fi

INSTALL_ARRAY=()
PYTHON_REQUIREMENTS_ARRAY=()
VSCODE_EXTENSIONS_ARRAY=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            usage
            ;;
        -i|--in|--install)
            shift
            # Loop until the next argument is an option or we run out of arguments
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                INSTALL_ARRAY+=("$1")
                shift
            done
            ;;
        -p|--python|python-requirements)
            shift
            # Loop until the next argument is an option or we run out of arguments
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                PYTHON_REQUIREMENTS_ARRAY+=("$1")
                shift
            done
            ;;
        -v|--vs|--vscode-extensions)
            shift
            # Loop until the next argument is an option or we run out of arguments
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                VSCODE_EXTENSIONS_ARRAY+=("$1")
                shift
            done
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Configuration
ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)
ENV_DIR="${ROOT_DIR}/env"
ENV_FILE="${ENV_DIR}/.env"

# Configuration Load
source "${ENV_FILE}"
source "${TOOLS_DIR}/utils/join_by_string.sh"

# Configuration Install
INSTALL=()
for i in ${INSTALL_ARRAY[@]}; do
    for j in $(grep -Ev '^#|^$' "${i}"); do
        INSTALL+=("${j}")
    done
done
INSTALL=($(printf "%s\n" "${INSTALL[@]}" | awk '!x[$0]++'))
INSTALL_CONTEXT=$(join_by_string "\n" "${INSTALL[@]}")

# Configuration Python requirements
PYTHON_REQUIREMENTS=()
for i in ${PYTHON_REQUIREMENTS_ARRAY[@]}; do
    for j in $(grep -Ev '^#|^$' "${i}"); do
        PYTHON_REQUIREMENTS+=("${j}")
    done
done
PYTHON_REQUIREMENTS=($(printf "%s\n" "${PYTHON_REQUIREMENTS[@]}" | awk '!x[$0]++'))
PYTHON_REQUIREMENTS_CONTEXT=$(join_by_string "\n" "${PYTHON_REQUIREMENTS[@]}")

# Configuration VSCode extensions
VSCODE_EXTENSIONS=()
for i in ${VSCODE_EXTENSIONS_ARRAY[@]}; do
    for j in $(grep -Ev '^#|^$' "${i}"); do
        VSCODE_EXTENSIONS+=("${j}")
    done
done
VSCODE_EXTENSIONS=($(printf "%s\n" "${VSCODE_EXTENSIONS[@]}" | awk '!x[$0]++'))
VSCODE_EXTENSIONS_CONTEXT=$(join_by_string "\n" "${VSCODE_EXTENSIONS[@]}")

# Output
echo -e ${INSTALL_CONTEXT} > "${INSTALL_TXT}"
echo -e ${PYTHON_REQUIREMENTS_CONTEXT} > "${PYTHON_REQUIREMENTS_TXT}"
echo -e ${VSCODE_EXTENSIONS_CONTEXT} > "${VSCODE_EXTENSIONS_TXT}"
