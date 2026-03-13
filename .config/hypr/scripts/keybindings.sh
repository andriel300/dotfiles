#!/bin/bash

# Path to keybinding config file
config_file="${HOME}/.config/hypr/conf.d/07-keybinding.conf"
echo "Reading from: $config_file"

# Ensure the file exists
if [[ ! -f "$config_file" ]]; then
	echo "Error: Keybinding config file not found at $config_file"
	exit 1
fi

keybinds=""

# Detect and process keybinding lines
while read -r line; do
	# Match lines starting with 'bind' or 'bindm'
	if [[ "$line" =~ ^[[:space:]]*bind ]]; then
		line="$(echo "$line" | sed 's/$mainMod/SUPER/g')"
		line="$(echo "$line" | sed 's/bind = //g')"
		line="$(echo "$line" | sed 's/bindm = //g')"

		IFS='#'
		read -a strarr <<<"$line"
		kb_str=${strarr[0]}
		cm_str=${strarr[1]}

		IFS=','
		read -a kbarr <<<"$kb_str"

		item="${kbarr[0]}  + ${kbarr[1]}"$'\r'"${cm_str:1}"
		keybinds+="$item"$'\n'
	fi
done <"$config_file"

# Display keybindings in rofi
sleep 0.2
echo -e "$keybinds" | wofi --show dmenu --prompt "Keybinds" --insensitive
