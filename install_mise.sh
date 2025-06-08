#!/bin/bash

# This script downloads the mise install script to a temp file, shows it to the
# user, and asks for confirmation before running

set -e  # Exit on any error

echo "Checking mise installation..."

# Download the mise install script to a temp file
TEMP_SCRIPT=$(mktemp)
curl -fsSL https://mise.run -o "$TEMP_SCRIPT"

echo "The mise install script has been downloaded to $TEMP_SCRIPT."
echo "Review the script below. Press q to exit less."
less "$TEMP_SCRIPT"

echo ""
read -p "Do you want to proceed with running the mise install script? (y/n): " CONFIRM
if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    sh "$TEMP_SCRIPT"
    echo "mise installation completed"
else
    echo "Installation aborted by user."
    rm -f "$TEMP_SCRIPT"
    exit 1
fi

# Check if mise activation is already in .zshrc
ZSHRC_FILE="$HOME/.zshrc"
ACTIVATION_LINE='[ -x ~/.local/bin/mise ] && eval "$(~/.local/bin/mise activate zsh)"'

echo ""
echo "Checking shell activation setup..."

if [ -f "$ZSHRC_FILE" ] && grep -q "mise activate" "$ZSHRC_FILE"; then
    echo "mise activation is already configured in ~/.zshrc"
else
    echo "mise activation needs to be added to your shell configuration"
    echo ""
    echo "Please add the following line to your ~/.zshrc file:"
    echo "  $ACTIVATION_LINE"
    echo ""
    echo "You can do this by running:"
    echo "  echo '$ACTIVATION_LINE' >> ~/.zshrc"
    echo ""
    echo "After adding the line, restart your shell or run:"
    echo "  source ~/.zshrc"
fi

echo ""
echo "After setup is complete, you can:"
echo "  - Update mise: mise self-update"
echo "  - Check for outdated tools: mise outdated"
echo "  - Upgrade tools: mise upgrade"
echo ""
echo "For other shells, see: https://mise.jdx.dev/getting-started.html#activate-mise"
