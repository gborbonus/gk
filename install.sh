!/bin/bash

INSTALL_DIR="/usr/local/bin"
COMPLETION_DIR="/etc/bash_completion.d"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (e.g., sudo $0)"
    exit 1
fi

# Install gk
cp gk "$INSTALL_DIR/gk"
chmod +x "$INSTALL_DIR/gk"
echo "Installed gk to $INSTALL_DIR/gk"

# Install completion
if [ -d "$COMPLETION_DIR" ]; then
    cp gk.sh "$COMPLETION_DIR/gk"
    chmod +x "$COMPLETION_DIR/gk"
    echo "Installed completion to $COMPLETION_DIR/gk.sh"
else
    echo "Warning: $COMPLETION_DIR not found; completion not installed"
fi

echo "Installation complete. Reload your shell (e.g., 'source ~/.bashrc') to enable completion."
