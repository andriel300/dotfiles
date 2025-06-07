#!/bin/bash

# Directory containing wallpapers
wall_dir="${HOME}/.config/backgrounds/wallpapers"
# Cache directory for processed thumbnails
cache_dir="${HOME}/.cache/wallpaper_thumbnails"
# Rofi command with theme
rofi_command="rofi -dmenu -theme ${HOME}/.config/rofi/wallpaper_selector.rasi"

# Create cache directory if it doesn't exist
mkdir -p "${cache_dir}"

# Monitor resolution
physical_monitor_size=27
monitor_res=$(hyprctl monitors | grep -A2 "Monitor" | grep "resolution" | awk '{print $2}' | cut -d'x' -f1)

# Fallback for monitor resolution
if [[ -z "$monitor_res" || "$monitor_res" -eq 0 ]]; then
	echo "Error: Could not retrieve monitor resolution. Falling back to 1920."
	monitor_res=1920
fi

# Adjust for DPI
dotsperinch=$(echo "scale=2; $monitor_res / $physical_monitor_size" | bc | xargs printf "%.0f")
monitor_res=$(($monitor_res * $physical_monitor_size / $dotsperinch))

# Convert wallpapers to thumbnails
for image in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
	if [ -f "$image" ]; then
		filename=$(basename "$image")
		if [ ! -f "${cache_dir}/${filename}" ]; then
			echo "Generating thumbnail for: $image"
			magick -strip "$image" -thumbnail 400x400^ -gravity center -extent 400x400 "${cache_dir}/${filename}"
		fi
	fi
done

# Display wallpaper selection in Rofi
wall_selection=$(find "${wall_dir}" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
	-exec basename {} \; | sort |
	while read -r filename; do echo -en "$filename\x00icon\x1f${cache_dir}/$filename\n"; done |
	$rofi_command)

# Exit if no selection is made
[[ -n "$wall_selection" ]] || exit 1

# Set selected wallpaper
swww img -t grow "${wall_dir}/${wall_selection}"
