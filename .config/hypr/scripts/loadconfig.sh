#!/bin/bash

# Simple Hyprland Reload Script
# Features:
# - Basic error checking
# - Success/failure notification
# - Clean and minimal

# Reload Hyprland and check result
if hyprctl reload; then
	notify-send -u low "Hyprland" "Config reloaded successfully"
else
	notify-send -u critical "Hyprland" "Failed to reload config!"
	exit 1
fi

# Wait for Hyprland to be ready
sleep 1
