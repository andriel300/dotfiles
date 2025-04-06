#!/bin/bash
# Usage: switch_workspace.sh <workspace_number>
hyprctl dispatch workspace "$1"
pw-play --volume 0.5 '/home/diel/Music/Saved Audio/macOS Big Sur Sounds/Tink.wav'
