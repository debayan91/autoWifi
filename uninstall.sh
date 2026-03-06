#!/bin/bash

launchctl unload ~/Library/LaunchAgents/com.autowifi.login.plist

rm ~/Library/LaunchAgents/com.autowifi.login.plist

echo "autoWifi removed"