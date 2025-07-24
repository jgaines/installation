#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")" || exit 1

# Function to display usage
usage() {
    echo "Usage: $0 <location>"
    echo "  location: work or home"
    exit 1
}

# Check if location parameter is provided
if [ $# -ne 1 ]; then
    echo "Error: Location parameter is required"
    usage
fi

LOCATION="$1"

# Validate location parameter
if [[ "$LOCATION" != "work" && "$LOCATION" != "home" ]]; then
    echo "Error: Location must be 'work' or 'home'"
    usage
fi

./backup_brew.sh "$LOCATION"
./backup_mise.sh "$LOCATION"
./backup_vscode.sh "$LOCATION"
