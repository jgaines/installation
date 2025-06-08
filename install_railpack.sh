#!/usr/bin/env bash

# This script downloads the Railpack install script to a temp file, shows it to the
# user, and asks for confirmation before running.

set -e  # Exit on any error

echo "Checking Railpack installation..."

# Download the Railpack install script to a temp file
TEMP_SCRIPT=$(mktemp)
curl -fsSL https://railpack.com/install.sh -o "$TEMP_SCRIPT"

if [ ! -s "$TEMP_SCRIPT" ]; then
    echo "Failed to download the Railpack install script."
    exit 1
fi

echo "The Railpack install script has been downloaded to $TEMP_SCRIPT."
echo "Review the script below. Press q to exit less."
less "$TEMP_SCRIPT"

echo ""
read -p "Do you want to proceed with running the Railpack install script? (y/n): " CONFIRM
if [ "$CONFIRM" = "y" ] || [ "$CONFIRM" = "Y" ]; then
    sh "$TEMP_SCRIPT"
    echo "Railpack installation completed"
else
    echo "Installation aborted by user."
    rm -f "$TEMP_SCRIPT"
    exit 1
fi
