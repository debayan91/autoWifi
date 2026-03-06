#!/bin/bash

# Get the absolute path of the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Make the login script executable
chmod +x "$SCRIPT_DIR/autowifi.sh"

# Ensure the LaunchAgents folder exists
mkdir -p ~/Library/LaunchAgents

# Dynamically generate the plist with the absolute path
cat <<EOF > ~/Library/LaunchAgents/com.autowifi.login.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.autowifi.login</string>
    <key>ProgramArguments</key>
    <array>
        <string>$SCRIPT_DIR/autowifi.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>


   <key>KeepAlive</key>
   <true/>
   


</dict>
</plist>
EOF

# Unload any broken versions that might be stuck
launchctl unload ~/Library/LaunchAgents/com.autowifi.login.plist 2>/dev/null

# Load the new, correct version
launchctl load ~/Library/LaunchAgents/com.autowifi.login.plist

echo "autoWifi installed successfully with the correct path!"