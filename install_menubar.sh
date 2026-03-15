#!/bin/bash

# Get the directory of the script
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST_NAME="com.autowifi.menubar.plist"
TARGET_DIR="$HOME/Library/LaunchAgents"

echo "Installing autoWifi Menu Bar App LaunchAgent..."

# Make menubar.py executable
chmod +x "$REPO_DIR/menubar.py"

# Create a temporary plist with absolute paths
PLIST_PATH="$TARGET_DIR/$PLIST_NAME"
cp "$REPO_DIR/$PLIST_NAME" "$PLIST_PATH"

# Get the absolute path to python3
PYTHON_PATH=$(which python3)

# Replace placeholders with absolute paths
sed -i '' "s|/usr/bin/python3|$PYTHON_PATH|g" "$PLIST_PATH"
sed -i '' "s|REPLACE_WITH_ABSOLUTE_PATH_TO_MENUBAR_PY|$REPO_DIR/menubar.py|g" "$PLIST_PATH"
sed -i '' "s|REPLACE_WITH_ABSOLUTE_PATH_TO_REPO_DIR|$REPO_DIR|g" "$PLIST_PATH"

# Load the LaunchAgent
launchctl unload "$PLIST_PATH" 2>/dev/null
launchctl load "$PLIST_PATH"

echo "Success! The menu bar app should now be running and will start automatically on login."
echo "You can check it in your macOS menu bar (text: 'WiFi')."
