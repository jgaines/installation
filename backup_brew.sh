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

# Define backup destination paths
REPO_BREW_DIR="./brew_settings"
BREW_BACKUP_DIR="$REPO_BREW_DIR/$LOCATION"

# Function to create directory if it doesn't exist
create_dir() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        echo "Creating directory: $dir"
        mkdir -p "$dir"
    fi
}

# Function to backup brew packages
backup_brew() {
    local dest_dir="$1"
    local app_name="$2"
    
    if ! command -v brew >/dev/null 2>&1; then
        echo "Warning: $app_name command not found: brew"
        return 1
    fi
    
    echo "Backing up $app_name packages to: $dest_dir/Brewfile"
    create_dir "$dest_dir"
    
    if brew bundle dump --force --file="$dest_dir/Brewfile" 2>/dev/null; then
        local count=$(grep -c "^brew\|^cask\|^tap\|^mas" "$dest_dir/Brewfile" 2>/dev/null || echo 0)
        echo "  Saved $count package entries"
        return 0
    else
        echo "  Warning: Failed to generate Brewfile"
        return 1
    fi
}

echo "Starting Homebrew settings backup for location: $LOCATION"

# Create new revset for this backup
jj new -m "backup_brew: $LOCATION brew settings"

# Create main brew_settings directory
create_dir "$REPO_BREW_DIR"

# Backup Homebrew packages and track success
if backup_brew "$BREW_BACKUP_DIR" "Homebrew"; then
    brew_success=true
else
    brew_success=false
fi

echo "Backup completed successfully!"
echo "Files backed up to:"

if [ "$brew_success" = true ]; then
    echo "  Homebrew: $BREW_BACKUP_DIR"
    echo "    Brewfile: backed up"
else
    echo "  Homebrew: not found"
fi
