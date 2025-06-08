#!/bin/bash

# Script to install mise based on documented steps
# This script installs mise and provides instructions for shell activation

set -e  # Exit on any error

echo "Installing mise..."

# Check if mise is already installed
if command -v mise &> /dev/null; then
    echo "mise is already installed at $(which mise)"
    mise --version
else
    echo "Installing mise..."
    curl https://mise.run | sh
    echo "mise installation completed"
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
