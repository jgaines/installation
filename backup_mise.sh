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

# Define source and backup destination paths
MISE_CONFIG_DIR="$HOME/allmise"
REPO_MISE_DIR="./mise_settings"
MISE_BACKUP_DIR="$REPO_MISE_DIR/$LOCATION"

# Function to create directory if it doesn't exist
create_dir() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        echo "Creating directory: $dir"
        mkdir -p "$dir"
    fi
}

# Function to backup mise configuration
backup_mise() {
    local source_dir="$1"
    local dest_dir="$2"
    local app_name="$3"
    
    if ! command -v mise >/dev/null 2>&1; then
        echo "Warning: $app_name command not found: mise"
        return 1
    fi
    
    if [ ! -d "$source_dir" ]; then
        echo "Warning: $app_name config directory not found: $source_dir"
        return 1
    fi
    
    if [ ! -f "$source_dir/mise.toml" ]; then
        echo "Warning: $app_name config file not found: $source_dir/mise.toml"
        return 1
    fi
    
    echo "Backing up $app_name configuration to: $dest_dir"
    create_dir "$dest_dir"
    
    # Copy mise.toml file
    echo "  Copying: mise.toml"
    cp "$source_dir/mise.toml" "$dest_dir/backup.mise.toml"
    
    return 0
}

echo "Starting mise settings backup for location: $LOCATION"

# Create new revset for this backup
jj new -m "backup_mise: $LOCATION mise settings"

# Create main mise_settings directory
create_dir "$REPO_MISE_DIR"

# Backup mise configuration and track success
if backup_mise "$MISE_CONFIG_DIR" "$MISE_BACKUP_DIR" "mise"; then
    mise_success=true
else
    mise_success=false
fi

echo "Backup completed successfully!"
echo "Files backed up to:"

if [ "$mise_success" = true ]; then
    echo "  mise: $MISE_BACKUP_DIR"
    echo "    Configuration: backed up"
    echo "    Restoration commands: generated"
else
    echo "  mise: not found"
fi
