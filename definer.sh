#!/bin/bash

# Define installation path
INSTALL_PATH="/usr/local/bin/definer"
ALIAS_COMMAND='definer:() { /usr/local/bin/definer "$1"; }'

# Ensure script is run with sudo
if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root using: sudo ./install_definer.sh"
    exit 1
fi

# Install 'dict' command if missing
if ! command -v dict &> /dev/null; then
    echo "'dict' command not found. Installing it..."
    if command -v apt &> /dev/null; then
        apt update && apt install -y dict
    elif command -v yum &> /dev/null; then
        yum install -y dict
    elif command -v dnf &> /dev/null; then
        dnf install -y dict
    else
        echo "Package manager not found! Please install 'dict' manually."
        exit 1
    fi
fi

# Create the Python script
echo "Creating definer script..."
cat <<EOF > $INSTALL_PATH
#!/usr/bin/env python3
import sys
import requests
import subprocess

def get_definition(word):
    """Fetch the definition using the `dict` command or an API."""
    try:
        result = subprocess.run(["dict", word], capture_output=True, text=True)
        if result.stdout.strip():
            return result.stdout.strip()
    except FileNotFoundError:
        pass  # If dict is not available, fallback to API

    # Fallback to an online dictionary API
    try:
        response = requests.get(f"https://api.dictionaryapi.dev/api/v2/entries/en/{word}")
        data = response.json()
        if isinstance(data, list) and "meanings" in data[0]:
            meaning = data[0]["meanings"][0]["definitions"][0]["definition"]
            return f"{word}: {meaning}"
    except Exception as e:
        return f"Error fetching definition: {e}"

    return f"No definition found for '{word}'."

def main():
    if len(sys.argv) < 2:
        print("Usage: definer: <word>")
        sys.exit(1)

    word = sys.argv[1]
    print(get_definition(word))

if __name__ == "__main__":
    main()
EOF

# Ensure the script is executable
chmod +x $INSTALL_PATH
echo "Installed definer script to $INSTALL_PATH"

# Detect the user's shell
USER_SHELL=$(basename "$SHELL")

# Determine which profile file to edit
if [[ "$USER_SHELL" == "bash" ]]; then
    PROFILE_FILE="$HOME/.bashrc"
elif [[ "$USER_SHELL" == "zsh" ]]; then
    PROFILE_FILE="$HOME/.zshrc"
else
    PROFILE_FILE="$HOME/.profile"
fi

# Add function if not already present
if ! grep -q "definer:" "$PROFILE_FILE"; then
    echo "$ALIAS_COMMAND" >> "$PROFILE_FILE"
    echo "Added 'definer:' function to $PROFILE_FILE"
else
    echo "'definer:' function already exists in $PROFILE_FILE"
fi

# Reload the shell profile
source "$PROFILE_FILE"

echo "Installation complete! You can now use 'definer:' in your terminal."
echo "Example: definer: hello"


