#!/usr/bin/env bash

# Kill existing Waybar (forcefully)
pkill -9 -x waybar

# Wait for process to fully terminate
while pgrep -x waybar >/dev/null; do
	sleep 0.1
done

# Relaunch Waybar in the correct Hyprland environment
# Use `nohup` to prevent hang-ups and redirect logs to /dev/null
nohup waybar >/dev/null 2>&1 &
disown

# Send a notification confirming reload
notify-send -t 2000 "(Waybar Reloaded)" "configuration has been successfully reloaded."

echo "Waybar reloaded successfully."
