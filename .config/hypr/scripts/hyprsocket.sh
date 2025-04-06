#!/usr/bin/env bash

# You can copy and paste this function and command in the bottom and replace the sounds that are played
# More info can be found in https://wiki.hyprland.org/IPC
handle() {
	case $1 in
	workspacev2*) pw-play --volume 0.5 '/home/diel/Music/Saved Audio/Smooth/window-slide.oga' & ;;
	openwindow*) pw-play --volume 0.5 '/home/diel/Music/Saved Audio/Smooth/window-new.oga' & ;;
	closewindow*) pw-play --volume 0.5 '/home/diel/Music/Saved Audio/Smooth/window-close.oga' & ;;
	movewindowv2*) pw-play --volume 0.5 '/home/diel/Music/Saved Audio/macOS Big Sur Sounds/Frog.wav' & ;;
	changefloatingmode\>\>*,1) pw-play --volume 0.5 '/home/diel/Music/Saved Audio/macOS Big Sur Sounds/Purr.wav' & ;;
	changefloatingmode\>\>*,0) pw-play --volume 0.5 '/home/diel/Music/Saved Audio/macOS Big Sur Sounds/Pop.wav' & ;;
	openlayer\>\>nwg-drawer) pw-play --volume 1.5 '/home/diel/Music/Saved Audio/Windows7/button-toggle-off.ogg' & ;;
	esac
}

# Connect to socket
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
