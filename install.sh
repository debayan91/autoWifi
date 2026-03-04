#!/bin/bash

chmod +x autowifi.sh

mkdir -p ~/Library/LaunchAgents

cp autowifi.plist ~/Library/LaunchAgents/com.autowifi.login.plist

launchctl load ~/Library/LaunchAgents/com.autowifi.login.plist

echo "autoWifi installed"