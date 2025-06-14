#!/usr/bin/env bash

# This script downloads the Railpack install script to a temp file, shows it to the
# user, and asks for confirmation before running.

set -e  # Exit on any error

cd $(dirname $0) || exit 1

echo "Checking Railpack installation..."

# Download the Railpack install script to a temp file
TEMP_SCRIPT=$(mktemp)
curl -fsSL https://railpack.com/install.sh -o "$TEMP_SCRIPT"

if [ ! -s "$TEMP_SCRIPT" ]; then
    echo "Failed to download the Railpack install script."
    exit 1
fi

echo "The Railpack install script has been downloaded to $TEMP_SCRIPT."
echo "Review the script below. Press q to exit."
if command -v bat &> /dev/null; then
    bat "$TEMP_SCRIPT"
else
    less "$TEMP_SCRIPT"
fi

echo ""
read -p "Do you want to proceed with running the Railpack install script? (y/n): " CONFIRM
if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    cat "$TEMP_SCRIPT" | sh
    echo "Railpack installation completed"
else
    echo "Installation aborted by user."
    rm -f "$TEMP_SCRIPT"
    exit 1
fi
