#!/bin/bash
#   ____ _ _       _     _     _
#  / ___| (_)_ __ | |__ (_)___| |_
# | |   | | | '_ \| '_ \| / __| __|
# | |___| | | |_) | | | | \__ \ |_
#  \____|_|_| .__/|_| |_|_|___/\__|
#           |_|
#

# Temporary directory for decoded images
TMP_DIR="/tmp/cliphist-icons"
mkdir -p "$TMP_DIR"
rm -f "$TMP_DIR"/*

# Load clipboard selection from cliphist and format with icon metadata
CLIPHIST_ENTRIES=$(cliphist list | gawk -v tmp="$TMP_DIR" '
    match($0, /^([0-9]+)\s(\[\[\s)?binary.*\.(jpg|jpeg|png|bmp)/, grp) {
        cmd = "cliphist decode <<<\"" grp[1] "\" > \"" tmp "/" grp[1] "." grp[3] "\""
        system(cmd)
        print $0 "\0icon\x1f" tmp "/" grp[1] "." grp[3]
        next
    }
    { print }
')

# Use rofi with icon support
SELECTION=$(echo -e "$CLIPHIST_ENTRIES" | rofi -dmenu -show-icons -config ~/.config/rofi/config-cliphist.rasi)

# Decode and copy selected entry
[[ -n "$SELECTION" ]] && cliphist decode <<<"$SELECTION" | wl-copy
