#!/bin/bash

# Common functions for color handling
source "${0%/*}/border-colors/Catppuccin.sh"
source "${0%/*}/border-colors/Nord.sh"
source "${0%/*}/border-colors/Gruvbox.sh"
source "${0%/*}/border-colors/Hyprland.sh"
source "${0%/*}/border-colors/Dracula.sh"

get_palette_colors() {
	local palette_name="$1"
	local -n output_array="$2"

	case "$palette_name" in
	"Catppuccin") output_array=("${CATPPUCCIN[@]}") ;;
	"Nord") output_array=("${NORD[@]}") ;;
	"Gruvbox Dark") output_array=("${GRUVBOX[@]}") ;;
	"Hyprland Default Colors") output_array=("${HYPRLAND[@]}") ;;
	"Dracula") output_array=("${DRACULA[@]}") ;;
	"Random Mix")
		local all_colors=()
		all_colors+=("${CATPPUCCIN[@]}" "${NORD[@]}" "${GRUVBOX[@]}" "${HYPRLAND[@]}" "${DRACULA[@]}")
		output_array=("${all_colors[@]}")
		;;
	esac
}

generate_gradient() {
	local palette_name="$1"
	local count="${2:-10}"
	local color_values=()

	get_palette_colors "$palette_name" color_values

	# Shuffle and select colors
	color_values=($(shuf -e "${color_values[@]}"))
	echo "${color_values[@]:0:$count}"
}

validate_colors() {
	for color in "$@"; do
		if ! [[ $color =~ ^0x[0-9a-fA-F]{6,8}$ ]]; then
			return 1
		fi
	done
	return 0
}
