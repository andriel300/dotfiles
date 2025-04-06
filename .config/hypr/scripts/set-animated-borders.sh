#!/bin/bash

# Catppuccin Latte Palette
declare -A catppuccin=(
	["rosewater"]="0xfff2d5cf"
	["flamingo"]="0xffeebebe"
	["pink"]="0xfff4b8e4"
	["mauve"]="0xffca9ee6"
	["red"]="0xffe78284"
	["maroon"]="0xffea999c"
	["peach"]="0xffef9f76"
	["yellow"]="0xffe5c890"
	["green"]="0xffa6d189"
	["teal"]="0xff81c8be"
	["sky"]="0xff99d1db"
	["sapphire"]="0xff85c1dc"
	["blue"]="0xff8caaee"
	["lavender"]="0xffbabbf1"
)

declare -A nord=(
	["nord0"]="0xff2e3440"
	["nord1"]="0xff3b4252"
	["nord2"]="0xff434c5e"
	["nord3"]="0xff4c566a"
	["nord4"]="0xffd8dee9"
	["nord5"]="0xffe5e9f0"
	["nord6"]="0xffeceff4"
	["nord7"]="0xff8fbcbb"
	["nord8"]="0xff88c0d0"
	["nord9"]="0xff81a1c1"
	["nord10"]="0xff5e81ac"
	["nord11"]="0xffbf616a"
	["nord12"]="0xffd08770"
	["nord13"]="0xffebcb8b"
	["nord14"]="0xffa3be8c"
	["nord15"]="0xffb48ead"
)

declare -A gruvbox_dark=(
	["dark0_hard"]="0xff1d2021"
	["dark0"]="0xff282828"
	["dark0_soft"]="0xff32302f"
	["dark1"]="0xff3c3836"
	["dark2"]="0xff504945"
	["dark3"]="0xff665c54"
	["dark4"]="0xff7c6f64"
	["gray_245"]="0xff928374"

	["light0_hard"]="0xfff9f5d7"
	["light0"]="0xfffbf1c7"
	["light0_soft"]="0xfff2e5bc"
	["light1"]="0xffebdbb2"
	["light2"]="0xffd5c4a1"
	["light3"]="0xffbdae93"
	["light4"]="0xffa89984"

	["bright_red"]="0xfffb4934"
	["bright_green"]="0xffb8bb26"
	["bright_yellow"]="0xfffabd2f"
	["bright_blue"]="0xff83a598"
	["bright_purple"]="0xffd3869b"
	["bright_aqua"]="0xff8ec07c"
	["bright_orange"]="0xffff8700"

	["neutral_red"]="0xffcc241d"
	["neutral_green"]="0xff98971a"
	["neutral_yellow"]="0xffd79921"
	["neutral_blue"]="0xff458588"
	["neutral_purple"]="0xffb16286"
	["neutral_aqua"]="0xff689d6a"
	["neutral_orange"]="0xffd65d0e"
)

declare -A hyprland_default_colors=(
	["aqua"]="0xee33ccff"      # from rgba(33ccffee)
	["turquoise"]="0xee00ff99" # from rgba(00ff99ee)
	["midpoint"]="0xee1ae6cc"  # brand new color in-between
	["lemon"]="0xeeffff99"     # pastel lemon: #FFFF99 w/ alpha=0xee
)

# Choose which one you want here:
chosen_palette="hyprland_default_colors"

function random_color() {
	# Access the chosen palette dynamically
	local -n palette_ref="$chosen_palette" # -n for nameref in Bash
	local keys=("${!palette_ref[@]}")
	local index=$((RANDOM % ${#keys[@]}))
	echo "${palette_ref[${keys[$index]}]}"
}

# Hyprland commands
hyprctl keyword general:col.active_border \
	"$(random_color)" \ "$(random_color)" \
	"$(random_color)" \ "$(random_color)" \
	"$(random_color)" \ "$(random_color)" \
	"$(random_color)" \ "$(random_color)" \
	"$(random_color)" \ "$(random_color)" \
	270deg

#hyprctl keyword general:col.inactive_border \
#	"$(random_color)" \ "$(random_color)" \
#	"$(random_color)" \ "$(random_color)" \
#	"$(random_color)" \ "$(random_color)" \
#	"$(random_color)" \ "$(random_color)" \
#	"$(random_color)" \ "$(random_color)" \
#	270deg
