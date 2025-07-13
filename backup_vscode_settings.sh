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
        return 1
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
    
    return 0
}

# Function to backup extensions list
backup_extensions() {
    local command_name="$1"
    local dest_dir="$2"
    local app_name="$3"
    
    if ! command -v "$command_name" >/dev/null 2>&1; then
        echo "Warning: $app_name command not found: $command_name"
        return 1
    fi
    
    echo "Backing up $app_name extensions to: $dest_dir/extensions.txt"
    create_dir "$dest_dir"
    
    if "$command_name" --list-extensions > "$dest_dir/extensions.txt" 2>/dev/null; then
        local count=$(wc -l < "$dest_dir/extensions.txt")
        echo "  Saved $count extensions"
        return 0
    else
        echo "  Warning: Failed to get extension list"
        return 1
    fi
}

echo "Starting VS Code settings backup for location: $LOCATION"

# Create new changeset for this backup
jj new -m "backup_vscode_settings: $LOCATION vscode settings"

# Create main vscode_settings directory
create_dir "$REPO_CODE_DIR"

# Backup VS Code settings and track success
if backup_files "$VSCODE_CONFIG_DIR" "$VSCODE_BACKUP_DIR" "VS Code"; then
    vscode_success=true
else
    vscode_success=false
fi

# Backup VS Code Insiders settings and track success
if backup_files "$VSCODE_INSIDERS_CONFIG_DIR" "$VSCODE_INSIDERS_BACKUP_DIR" "VS Code Insiders"; then
    vscode_insiders_success=true
else
    vscode_insiders_success=false
fi

# Backup extensions and track success
if backup_extensions "code" "$VSCODE_BACKUP_DIR" "VS Code"; then
    vscode_extensions_success=true
else
    vscode_extensions_success=false
fi

if backup_extensions "code-insiders" "$VSCODE_INSIDERS_BACKUP_DIR" "VS Code Insiders"; then
    vscode_insiders_extensions_success=true
else
    vscode_insiders_extensions_success=false
fi

echo "Backup completed successfully!"
echo "Files backed up to:"

if [ "$vscode_success" = true ]; then
    echo "  VS Code: $VSCODE_BACKUP_DIR"
    if [ "$vscode_extensions_success" = true ]; then
        echo "    Extensions: backed up"
    else
        echo "    Extensions: not found"
    fi
else
    echo "  VS Code: not found"
fi

if [ "$vscode_insiders_success" = true ]; then
    echo "  VS Code Insiders: $VSCODE_INSIDERS_BACKUP_DIR"
    if [ "$vscode_insiders_extensions_success" = true ]; then
        echo "    Extensions: backed up"
    else
        echo "    Extensions: not found"
    fi
else
    echo "  VS Code Insiders: not found"
fi
