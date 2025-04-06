#!/bin/bash

# Configuration
THEME="${ROFI_THEME:-$HOME/.config/rofi/config.rasi}"
PID_FILE="/tmp/radio-mpv.pid"
HISTORY_FILE="$HOME/.cache/rofi_music_history"
mkdir -p "$(dirname "$HISTORY_FILE")"

# Notification function
notification() {
	notify-send "Music Player" "$@" --icon=media-tape
}

# Main menu
menu() {
	printf "1. Lofi Girl ☕️🎶\n"
	printf "2. Chillhop ☕️🎶\n"
	printf "3. Box Lofi ☕️🎶\n"
	printf "4. The Bootleg Boy ☕️🎶\n"
	printf "5. Radio Spinner ☕️🎶\n"
	printf "6. SmoothChill ☕️🎶\n"
	printf "7. Deep Focus Study 📚\n"
	printf "8. Rain Sounds 🌧️ \n"
	printf "9. Fireplace Crackling 🔥 \n"
	printf "10. White Noise Study 🎧 \n"
	printf "11. Brown Noise Study 🎧 \n"
	printf "12. Forest Sounds 🌲 \n"
	printf "16. Stop & Exit\n"
}

# Play stream function
play_stream() {
	local url="$1"
	local volume="$2"
	local title="$3"
	mpv --no-video --volume="$volume" --title="radio-mpv" --ytdl --ytdl-format="bestaudio" --loop-playlist "$url" &>/dev/null &
	pid=$!
	if [ $? -eq 0 ]; then
		echo "$pid" >"$PID_FILE"
		save_history "$url"
		notification "$title"
	else
		notification "Error" "Failed to play $url" --icon=error
		rm -f "$PID_FILE"
	fi
}

# Main function
main() {
	choice=$(menu | rofi -dmenu -i -theme "$THEME" -p "Select Music Stream" | cut -d. -f1)

	# Stop existing stream if a new one is selected
	if [ -n "$choice" ] && [ "$choice" -ne 15 ] && [ "$choice" -ne 16 ] && [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
		pkill -f "radio-mpv" && rm -f "$PID_FILE"
	fi

	case "$choice" in
	1) play_stream "https://www.youtube.com/watch?v=jfKfPfyJRdk" 70 "Lofi Girl ☕️🎶" ;;
	2) play_stream "https://www.youtube.com/watch?v=5yx6BWlEVcY" 60 "Chillhop ☕️🎶" ;;
	3) play_stream "https://www.youtube.com/watch?v=DWcJFNfaw9c" 60 "Box Lofi ☕️🎶" ;;
	4) play_stream "https://www.youtube.com/watch?v=A_hmrykwR7g" 60 "The Bootleg Boy ☕️🎶" ;;
	5) play_stream "https://www.youtube.com/watch?v=kgx4WGK0oNU" 60 "Radio Spinner ☕️🎶" ;;
	6) play_stream "https://www.youtube.com/watch?v=lTRiuFIWV54" 60 "SmoothChill ☕️🎶" ;;
	7) play_stream "https://www.youtube.com/playlist?list=PLedq9ElFqyovtjE-RXFe2Ct9dQk1T9wh3" 100 "Deep Focus Study Playlist 🎧📚" ;;
	8) play_stream "https://www.youtube.com/watch?v=mPZkdNFkNps" 80 "Rain Sounds 🌧️" ;;
	9) play_stream "https://www.youtube.com/watch?v=eyU3bRy2x44" 100 "Fireplace Crackling 🔥" ;;
	10) play_stream "https://www.youtube.com/watch?v=nMfPqeZjc2c" 60 "White Noise 🎧" ;;
	11) play_stream "https://www.youtube.com/watch?v=0GDfOAuUvQ0" 60 "Brown Noise Study Focus 🎧" ;;
	12) play_stream "https://www.youtube.com/watch?v=OdIJ2x3nxzQ" 80 "Forest Sounds 🌲" ;;
	16 | "")
		if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
			pkill -f "radio-mpv" && rm -f "$PID_FILE" && notification "Stopped & Exited"
		fi
		exit 0
		;;
	*) notification "Invalid option" && exit 1 ;;
	esac
}

# Check dependencies
for cmd in mpv rofi notify-send; do
	if ! command -v "$cmd" &>/dev/null; then
		echo "Error: $cmd is not installed." >&2
		exit 1
	fi
done

# Run main if no arguments, otherwise handle controls
if [ -z "$1" ]; then
	main
else
	case "$1" in
	"control") control_menu ;;
	esac
fi
