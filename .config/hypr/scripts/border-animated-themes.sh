#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$SCRIPT_DIR/border-colors/colors-common.sh"

# Theme selection via Rofi
THEMES=(
	"Disable Borders"
	"Catppuccin"
	"Nord"
	"Gruvbox Dark"
	"Hyprland Default Colors"
	"Dracula"
	"Random Mix"
)

# Get user selection
SELECTED_THEME=$(printf "%s\n" "${THEMES[@]}" | wofi --show dmenu --prompt "")

if [[ -z "$SELECTED_THEME" ]]; then
	exit 0
fi

if [[ "$SELECTED_THEME" == "Disable Borders" ]]; then
	# Disable borders completely
	hyprctl keyword general:border_size 0
	# hyprctl keyword decoration:rounding 0
	notify-send "Borders Disabled" "Window borders have been hidden"
else
	# Enable borders first (in case they were disabled)
	hyprctl keyword general:border_size 2 # Or your default size
	# hyprctl keyword decoration:rounding 5  # Or your default rounding

	# Get colors as an array
	COLORS=($(generate_gradient "$SELECTED_THEME" 10))

	# Verify we have colors
	if [ ${#COLORS[@]} -eq 0 ]; then
		notify-send "Error" "No colors generated for theme: $SELECTED_THEME"
		exit 1
	fi

	# Build and execute hyprctl command
	CMD=("hyprctl" "keyword" "general:col.active_border")
	CMD+=("${COLORS[@]}")
	CMD+=("270deg")
	"${CMD[@]}"

	notify-send "Border Theme" "Applied $SELECTED_THEME Animated Borders"
fi
