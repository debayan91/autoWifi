#!/bin/bash

PLIST_NAME="com.autowifi.menubar.plist"
PLIST_PATH="$HOME/Library/LaunchAgents/$PLIST_NAME"

echo "Uninstalling autoWifi Menu Bar App LaunchAgent..."

if [ -f "$PLIST_PATH" ]; then
    # Unload and remove the plist
    launchctl unload "$PLIST_PATH" 2>/dev/null
    rm "$PLIST_PATH"
    echo "LaunchAgent removed successfully."
else
    echo "LaunchAgent not found. Already uninstalled?"
fi
