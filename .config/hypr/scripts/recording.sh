#!/usr/bin/env bash

mode=$1
output_dir="$HOME/Videos/Recordings"
pid_file="$HOME/.cache/recording.pid"
status_file="$HOME/.cache/recording.status"

# Create directories if needed
mkdir -p "$output_dir"
mkdir -p "$(dirname "$pid_file")"

# Check if recording is active
if [ -f "$pid_file" ]; then
	pid=$(cat "$pid_file")
	if kill -0 "$pid" 2>/dev/null; then
		# Stop recording
		kill -SIGINT "$pid"
		rm -f "$pid_file" "$status_file"

		# Update Waybar
		pkill -RTMIN+10 waybar

		# Send notification
		notify-send -t 5000 "Recording Stopped" "Video saved to $output_dir" \
			-a "Screen Recording" -i "media-record"
		exit 0
	else
		rm -f "$pid_file" "$status_file"
	fi
fi

# Generate filename
filename="$output_dir/Recording_$(date +'%Y-%m-%d_%H-%M-%S').mp4"

# Start recording based on mode
case $mode in
"region")
	geometry=$(slurp -f "%wx%h+%x+%y")
	[ -z "$geometry" ] && exit 0
	gpu-screen-recorder -w region -region "$geometry" -f 60 -o "$filename" &
	;;
"window")
	window_info=$(hyprctl activewindow | awk '/at:|size:/ {print $2}' | tr '\n' ' ' | sed 's/,//g')
	[ -z "$window_info" ] && exit 0
	gpu-screen-recorder -w region -region "$window_info" -f 60 -o "$filename" &
	;;
"fullscreen")
	gpu-screen-recorder -w screen -f 60 -o "$filename" &
	;;
*)
	exit 0
	;;
esac

# Save PID and update status
echo $! >"$pid_file"
echo "active" >"$status_file"

# Update Waybar
pkill -RTMIN+10 waybar

# Send notification with stop action
notify-send -t 5000 "Recording Started" "Click the icon again to stop" \
	-a "Screen Recording" -i "media-record" \
	-h string:x-canonical-private-synchronous:screen-recorder
