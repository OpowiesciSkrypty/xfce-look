#!/bin/bash

# Find the path to the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ask for the username
read -p "Enter the username: " USERNAME

# Determine the user's home directory path
HOME_DIR="/home/$USERNAME"

# Check if the home directory exists
if [ ! -d "$HOME_DIR" ]; then
  echo "The home directory for user $USERNAME does not exist."
  exit 1
fi

# Determine the paths to the .themes, .wallpapers, and .icons directories
THEMES_DIR="$HOME_DIR/.themes"
WALLPAPERS_DIR="$HOME_DIR/.wallpapers"
ICONS_DIR="$HOME_DIR/.icons"

# Create these directories if they don't exist
mkdir -p "$THEMES_DIR"
mkdir -p "$WALLPAPERS_DIR"
mkdir -p "$ICONS_DIR"

# Merge files in the icons directory
cd "$SCRIPT_DIR/icons"
cat part* > "$SCRIPT_DIR/icons/buff.zip"

# Unzip .zip files to the appropriate directories
for dir in themes wallpapers icons; do
  if [ -d "$SCRIPT_DIR/$dir" ]; then
    cd "$SCRIPT_DIR/$dir"
    for zip_file in *.zip; do
      if [ -f "$zip_file" ]; then
        echo "Unzipping $zip_file to $HOME_DIR/.$dir"
        unzip -o "$zip_file" -d "$HOME_DIR/.$dir"
      fi
    done
  fi
done

echo "Unzipping process completed."
