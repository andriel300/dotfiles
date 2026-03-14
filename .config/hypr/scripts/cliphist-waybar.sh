#!/bin/bash

case $1 in
c)
	cliphist list | wofi --dmenu \
		--prompt "Search Clipboard: " \
		--config ~/.config/wofi/cliphist.ini |
		cliphist decode | wl-copy
	;;
w)
	if [ "$(echo -e "Yes\nNo" | wofi --dmenu --prompt "Clear Clipboard History?" --config ~/.config/wofi/cliphist.ini)" = "Yes" ]; then
		cliphist wipe
	fi
	;;
d)
	selected=$(cliphist list | wofi --dmenu --prompt "Delete Clipboard Item:" --config ~/.config/wofi/cliphist.ini)
	if [ -n "$selected" ]; then
		cliphist delete "$selected"
	fi
	;;
l)
	cliphist list | wc -l
	;;
*)
	echo -e "cliphist.sh [action]"
	echo "c : cliphist list and copy selected"
	echo "d : cliphist list and delete selected"
	echo "w : cliphist wipe database"
	echo "l : show the number of items in the clipboard"
	exit 1
	;;
esac
