#!/usr/bin/env bash

# This script downloads the Homebrew install script to a temp file, shows it to the
# user, and asks for confirmation before running.

set -e  # Exit on any error

echo "Checking Homebrew installation..."

# Download the Homebrew install script to a temp file
TEMP_SCRIPT=$(mktemp)
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o "$TEMP_SCRIPT"

if [ ! -s "$TEMP_SCRIPT" ]; then
    echo "Failed to download the Homebrew install script."
    exit 1
fi

echo "The Homebrew install script has been downloaded to $TEMP_SCRIPT."
echo "Review the script below. Press q to exit."
if command -v bat &> /dev/null; then
    bat "$TEMP_SCRIPT"
else
    less "$TEMP_SCRIPT"
fi

echo ""
read -p "Do you want to proceed with running the Homebrew install script? (y/n): " CONFIRM
if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    cat "$TEMP_SCRIPT" | bash
    echo "Homebrew installation completed"
else
    echo "Installation aborted by user."
    rm -f "$TEMP_SCRIPT"
    exit 1
fi

# Check if Homebrew activation is already in shell configuration
SHELL_CONFIG=""
if [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
fi

echo ""
echo "Checking shell activation setup..."

# Check if Homebrew paths are already configured
if [ -n "$SHELL_CONFIG" ] && [ -f "$SHELL_CONFIG" ]; then
    if grep -q "linuxbrew" "$SHELL_CONFIG" || grep -q "homebrew" "$SHELL_CONFIG"; then
        echo "Homebrew activation appears to be already configured in $SHELL_CONFIG"
    else
        echo "Homebrew activation needs to be added to your shell configuration"
        echo ""
        echo "Add Homebrew paths to your PATH array and INFOPATH in $SHELL_CONFIG:"
        echo ""
        echo "In your path array, add:"
        echo '  /home/linuxbrew/.linuxbrew/bin'
        echo '  /home/linuxbrew/.linuxbrew/sbin'
        echo ""
        echo "And add this export line:"
        echo '  export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}";'
        echo ""
        echo "Note: This is different from the standard 'brew shellenv' approach"
        echo "and integrates better with custom PATH management."
        echo ""
        echo "After adding these lines, restart your shell or run:"
        echo "  source $SHELL_CONFIG"
    fi
else
    echo "Could not detect shell configuration file"
    echo "Please manually add Homebrew to your PATH:"
    echo "Add /home/linuxbrew/.linuxbrew/bin and /home/linuxbrew/.linuxbrew/sbin to PATH"
    echo 'Export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}"'
fi

echo ""
echo "After setup is complete, you can:"
echo "  - Update Homebrew: brew update"
echo "  - Upgrade packages: brew upgrade"
echo "  - Search packages: brew search <package>"
echo "  - Install packages: brew install <package>"
echo ""
echo "For more information, see: https://docs.brew.sh/"
