#!/bin/bash

# Check if a directory is passed as an argument
if [[ $# -lt 1 ]] || [[ ! -d $1 ]]; then
	echo "Usage:
	$0 <dir containing images>"
	exit 1
fi

# Environment variables for transitions
export SWWW_TRANSITION_FPS=120
export SWWW_TRANSITION_STEP=90

# Time interval between wallpaper changes (in seconds)
INTERVAL=300

# Define the desired transition type (e.g., fade, grow, slide, outer)
TRANSITION_TYPE="grow"

while true; do
	# Randomly pick one image and set it as the wallpaper with transition
	img=$(find "$1" -type f | shuf -n 1)
	swww img "$img" --transition-type "$TRANSITION_TYPE"
	sleep $INTERVAL
done
