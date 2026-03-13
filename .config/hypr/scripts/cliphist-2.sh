#!/bin/bash

scripts_dir=$HOME/.config/hypr/scripts

case $1 in
c)
	cliphist list | wofi --show dmenu --prompt "Search Clipboard" | cliphist decode | wl-copy
	;;
w)
	if [ "$(echo -e "Yes\nNo" | wofi --show dmenu --prompt "Clear Clipboard History?")" == "Yes" ]; then
		cliphist wipe
	fi
	;;
l)
	cliphist list | wc -l
	;;
*)
	echo -e "cliphist.sh [action]"
	echo "c :  cliphist list and copy selected"
	echo "d :  cliphist list and delete selected"
	echo "w :  cliphist wipe database"
	echo "l :  show the number of items in the clipboard"
	exit 1
	;;
esac
