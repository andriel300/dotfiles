#!/bin/bash

EWW_CFG="$HOME/.config/eww"
POPUP_DURATION=5 # Increased from 2 to 3 seconds

# Get current volume percentage
get_volume() {
	pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%'
}

# Show popup and manage timer
show_popup() {
	# Close any existing popup first
	eww --config "$EWW_CFG" close volume 2>/dev/null

	# Update and show popup
	eww --config "$EWW_CFG" update volume=$(get_volume)
	eww --config "$EWW_CFG" open volume

	# Start timer in background
	{
		sleep $POPUP_DURATION
		# Only close if no one is hovering
		if ! eww --config "$EWW_CFG" get windows | grep -q "*volume"; then
			eww --config "$EWW_CFG" close volume
		fi
	} &
}

case "$1" in
--inc)
	pactl set-sink-volume @DEFAULT_SINK@ +5%
	show_popup
	;;
--dec)
	pactl set-sink-volume @DEFAULT_SINK@ -5%
	show_popup
	;;
--toggle)
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	show_popup
	;;
*)
	show_popup
	;;
esac
