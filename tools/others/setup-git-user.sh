#!/bin/sh

# Default flags
FORCE=0
USE_PRIMARY_EMAIL=0

# Usage help function
usage() {
    echo "\
Usage: $0 [OPTIONS]
Sync GitHub account profile details to local git config.

Prerequisites:
    - gh
    - git

Options:
    -f, --force          Overwrite existing git user.name and user.email
    -p, --primary-email  Use primary email from GitHub instead of the noreply email
    -h, --help           Display this help message\
"
    exit 1
}

# Parse command-line arguments
while [ $# -gt 0 ]; do
    case "$1" in
        -f|--force)
            FORCE=1
            shift
            ;;
        -p|--primary-email)
            USE_PRIMARY_EMAIL=1
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Error: Unknown option $1"
            usage
            ;;
    esac
done

# Step 1: Check existing Git configuration unless --force is specified
if [ "$FORCE" -ne 1 ]; then
    CURRENT_NAME="$(git config user.name 2>/dev/null)"
    CURRENT_EMAIL="$(git config user.email 2>/dev/null)"

    if [ -n "$CURRENT_NAME" ] || [ -n "$CURRENT_EMAIL" ]; then
        echo "Error: Git user settings already configured."
        echo "  user.name  : ${CURRENT_NAME:-<not set>}"
        echo "  user.email : ${CURRENT_EMAIL:-<not set>}"
        echo "Use -f or --force to overwrite the current settings."
        exit 1
    fi
fi

# Step 2: Retrieve user details from GitHub CLI (gh)
echo "Fetching GitHub user details..."

GH_USER="$(gh api user --jq '.name // .login')"

if [ "$USE_PRIMARY_EMAIL" -eq 1 ]; then
    GH_EMAIL="$(gh api user/emails --jq 'map(select(.primary == true))[0].email')"
else
    GH_EMAIL="$(gh api user --jq '.id')+$({ gh api user --jq '.login'; })@users.noreply.github.com"
fi

# Validate fetched parameters
if [ -z "$GH_USER" ] || [ -z "$GH_EMAIL" ]; then
    echo "Error: Failed to fetch user details from GitHub CLI. Make sure 'gh' is authenticated."
    exit 1
fi

# Step 3: Apply git configuration
git config user.name "${GH_USER}"
git config user.email "${GH_EMAIL}"

echo "Git configuration successfully updated:"
echo "  user.name  : ${GH_USER}"
echo "  user.email : ${GH_EMAIL}"
