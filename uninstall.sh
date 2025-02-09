#!/bin/bash

# Uninstall script for Definer

echo "Removing Definer script from /usr/local/bin..."
sudo rm -f /usr/local/bin/definer

echo "Removing Definer alias from shell profiles..."
sed -i '/definer:/d' ~/.bashrc ~/.zshrc ~/.profile

# Reload shell profiles
echo "Reloading shell profiles..."
source ~/.bashrc 2>/dev/null || true
source ~/.zshrc 2>/dev/null || true
source ~/.profile 2>/dev/null || true

echo "Uninstallation complete. Definer has been removed from your system."

