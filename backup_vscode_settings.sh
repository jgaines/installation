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

# Define source paths
VSCODE_CONFIG_DIR="$HOME/.config/Code"
VSCODE_INSIDERS_CONFIG_DIR="$HOME/.config/Code - Insiders"

# Define backup destination paths
REPO_CODE_DIR="./vscode_settings"
VSCODE_BACKUP_DIR="$REPO_CODE_DIR/$LOCATION"
VSCODE_INSIDERS_BACKUP_DIR="$REPO_CODE_DIR/i$LOCATION"

# Files to backup (same as in codesync)
FILES_TO_BACKUP=(
    "User/globalStorage/alefragnani.project-manager/projects.json"
    "User/keybindings.json"
    "User/settings.json"
)

# Function to create directory if it doesn't exist
create_dir() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        echo "Creating directory: $dir"
        mkdir -p "$dir"
    fi
}

# Function to backup files from source to destination
backup_files() {
    local source_dir="$1"
    local dest_dir="$2"
    local app_name="$3"
    
    if [ ! -d "$source_dir" ]; then
        echo "Warning: $app_name config directory not found: $source_dir"
        return
    fi
    
    echo "Backing up $app_name settings to: $dest_dir"
    create_dir "$dest_dir"
    
    for file in "${FILES_TO_BACKUP[@]}"; do
        source_file="$source_dir/$file"
        dest_file="$dest_dir/$file"
        
        if [ -f "$source_file" ]; then
            echo "  Copying: $file"
            create_dir "$(dirname "$dest_file")"
            cp "$source_file" "$dest_file"
        else
            echo "  Warning: File not found: $file"
        fi
    done
}

echo "Starting VS Code settings backup for location: $LOCATION"

# Create new changeset for this backup
jj new -m "back up $LOCATION vscode settings"

# Create main vscode_settings directory
create_dir "$REPO_CODE_DIR"

# Backup VS Code settings
backup_files "$VSCODE_CONFIG_DIR" "$VSCODE_BACKUP_DIR" "VS Code"

# Backup VS Code Insiders settings
backup_files "$VSCODE_INSIDERS_CONFIG_DIR" "$VSCODE_INSIDERS_BACKUP_DIR" "VS Code Insiders"

echo "Backup completed successfully!"
echo "Files backed up to:"
echo "  VS Code: $VSCODE_BACKUP_DIR"
echo "  VS Code Insiders: $VSCODE_INSIDERS_BACKUP_DIR"
