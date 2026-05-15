#!/bin/bash
~/.config/hypr/scripts/play-sound.sh window-close &
hyprctl dispatch "hl.dsp.window.close()"
