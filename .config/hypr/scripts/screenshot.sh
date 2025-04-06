#!/usr/bin/env bash

mode=$1
filename="$HOME/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"

case $mode in
"region")
	grimblast --notify save area "$filename" && wl-copy <"$filename"
	;;
"window")
	grimblast --notify save active "$filename" && wl-copy <"$filename"
	;;
"fullscreen")
	grimblast --notify save screen "$filename" && wl-copy <"$filename"
	;;
*)
	exit 0
	;;
esac

# Send notification with preview
if [ -f "$filename" ]; then
	notify-send -i "$filename" "Screenshot Taken" "Saved to $filename & Copied to Clipboard"
fi
