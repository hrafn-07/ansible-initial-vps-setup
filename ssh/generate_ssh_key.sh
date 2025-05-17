#!/bin/zsh

# Script to generate an SSH key pair named 'ansible_user_key' in the current directory (ssh/)

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Define the fixed key filename
KEY_FILENAME="ansible_user_key"

echo "Generating SSH key pair with fixed name: $KEY_FILENAME..."

# Define full paths for the keys
PRIVATE_KEY_PATH="$SCRIPT_DIR/$KEY_FILENAME"
PUBLIC_KEY_PATH="$SCRIPT_DIR/$KEY_FILENAME.pub"

# Check if key files already exist
if [ -f "$PRIVATE_KEY_PATH" ] || [ -f "$PUBLIC_KEY_PATH" ]; then
  echo "Key files '$PRIVATE_KEY_PATH' or '$PUBLIC_KEY_PATH' already exist."
  echo "Please remove them or back them up if you want to generate a new set."
  exit 1
fi

# Generate the SSH key pair (ed25519 is generally recommended)
ssh-keygen -t ed25519 -f "$PRIVATE_KEY_PATH" -N "" -q

if [ $? -eq 0 ]; then
  # Set permissions for the private key
  chmod 600 "$PRIVATE_KEY_PATH"
  echo "SSH key pair generated successfully:"
  echo "Private key: $PRIVATE_KEY_PATH"
  echo "Public key:  $PUBLIC_KEY_PATH"
else
  echo "SSH key generation failed."
  exit 1
fi
