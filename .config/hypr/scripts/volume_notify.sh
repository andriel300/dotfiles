#!/bin/bash

# Notification ID (for replacing)
NOTIF_ID=2598 # Can be any unique number

iDIR="$HOME/.config/dunst/icons/vol"

# Get icons
get_icon() {
	current=$(get_volume)
	if [[ "$current" == "Muted" ]]; then
		echo "$iDIR/muted-speaker.svg"
	elif [[ "${current%\%}" = 5 ]]; then
		echo "$iDIR/vol-5.svg"
	elif [[ "${current%\%}" = 10 ]]; then
		echo "$iDIR/vol-10.svg"
	elif [[ "${current%\%}" = 15 ]]; then
		echo "$iDIR/vol-15.svg"
	elif [[ "${current%\%}" = 20 ]]; then
		echo "$iDIR/vol-20.svg"
	elif [[ "${current%\%}" = 25 ]]; then
		echo "$iDIR/vol-25.svg"
	elif [[ "${current%\%}" = 30 ]]; then
		echo "$iDIR/vol-30.svg"
	elif [[ "${current%\%}" = 35 ]]; then
		echo "$iDIR/vol-35.svg"
	elif [[ "${current%\%}" = 40 ]]; then
		echo "$iDIR/vol-40.svg"
	elif [[ "${current%\%}" = 45 ]]; then
		echo "$iDIR/vol-45.svg"
	elif [[ "${current%\%}" = 50 ]]; then
		echo "$iDIR/vol-50.svg"
	elif [[ "${current%\%}" = 55 ]]; then
		echo "$iDIR/vol-55.svg"
	elif [[ "${current%\%}" = 60 ]]; then
		echo "$iDIR/vol-60.svg"
	elif [[ "${current%\%}" = 65 ]]; then
		echo "$iDIR/vol-65.svg"
	elif [[ "${current%\%}" = 70 ]]; then
		echo "$iDIR/vol-70.svg"
	elif [[ "${current%\%}" = 75 ]]; then
		echo "$iDIR/vol-75.svg"
	elif [[ "${current%\%}" = 80 ]]; then
		echo "$iDIR/vol-80.svg"
	elif [[ "${current%\%}" = 85 ]]; then
		echo "$iDIR/vol-85.svg"
	elif [[ "${current%\%}" = 90 ]]; then
		echo "$iDIR/vol-90.svg"
	elif [[ "${current%\%}" = 95 ]]; then
		echo "$iDIR/vol-95.svg"
	else
		echo "$iDIR/vol-100.svg"
	fi
}

get_volume() {
	pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%'
}

is_muted() {
	pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes"
}

case "$1" in
--inc)
	pactl set-sink-volume @DEFAULT_SINK@ +5%
	;;
--dec)
	pactl set-sink-volume @DEFAULT_SINK@ -5%
	;;
--toggle)
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	;;
esac

# Show notification
ICON=$(get_icon)
VOL=$(get_volume)

notify-send -r $NOTIF_ID \
	-i "$ICON" \
	-h int:value:"$VOL" \
	-t 1000 \
	-h string:x-canonical-private-synchronous:volume \
	"Volume" "$VOL%"
