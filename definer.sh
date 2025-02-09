#!/bin/bash

# Define installation paths
INSTALL_PATH="/usr/local/bin/definer"
WRAPPER_PATH="/usr/local/bin/definer:"

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

def get_definition(word, verbose):
    """Fetch the definition using the `dict` command if verbose, otherwise use an API."""
    if verbose:
        try:
            result = subprocess.run(["dict", word], capture_output=True, text=True)
            if result.stdout.strip():
                return result.stdout.strip()
        except FileNotFoundError:
            return "Error: `dict` command not found. Install `dict` or run without -v."
    
    # Default to API if `-v` is not set
    try:
        response = requests.get(f"https://api.dictionaryapi.dev/api/v2/entries/en/{word}", timeout=5)
        data = response.json()
        if isinstance(data, list) and data:
            for entry in data:
                if "meanings" in entry:
                    for meaning in entry["meanings"]:
                        if "definitions" in meaning:
                            definition = meaning["definitions"][0]["definition"]
                            return f"{word}: {definition}"
    except Exception as e:
        return f"Error fetching definition: {e}"

    return f"No definition found for '{word}'."

def main():
    if len(sys.argv) < 2:
        print("Usage: definer: <word> [-v]")
        sys.exit(1)

    word = sys.argv[1]
    verbose = "-v" in sys.argv
    print(get_definition(word, verbose))

if __name__ == "__main__":
    main()
EOF

# Ensure the Python script is executable
chmod +x $INSTALL_PATH
echo "Installed definer script to $INSTALL_PATH"

# Create a wrapper script to allow `definer:` to work
echo "Creating wrapper script for 'definer:'..."
cat <<EOF > $WRAPPER_PATH
#!/bin/bash
/usr/local/bin/definer "\$@"
EOF

# Make the wrapper executable
chmod +x $WRAPPER_PATH

# Ensure /usr/local/bin is in PATH
if ! echo "$PATH" | grep -q "/usr/local/bin"; then
    echo "export PATH=\$PATH:/usr/local/bin" >> ~/.bashrc
    echo "Added /usr/local/bin to PATH in ~/.bashrc"
fi

# Reload shell profile
echo "Sourcing ~/.bashrc..."
source ~/.bashrc

# Final message
echo "Installation complete! You can now use 'definer:' immediately."
echo "Example: definer: hello"
echo "Verbose mode (using 'dict' command): definer: hello -v"
