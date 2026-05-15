#!/bin/bash

case $1 in
--poweroff)
	"$HOME/.config/hypr/scripts/uptime.sh" && sleep 3
	systemctl poweroff --now
	;;
--reboot)
	"$HOME/.config/hypr/scripts/uptime.sh" && sleep 3
	systemctl reboot --now
	;;
--logout)
	"$HOME/.config/hypr/scripts/uptime.sh" && sleep 3
	hyprctl exit
	;;
--lock)
	hyprlock
	;;
esac
