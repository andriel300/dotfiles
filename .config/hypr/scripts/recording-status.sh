#!/usr/bin/env bash

status_file="$HOME/.cache/recording.status"

if [ -f "$status_file" ] && [ "$(cat "$status_file")" = "active" ]; then
	echo '{"text": "", "tooltip": "Recording in progress", "class": "active"}'
else
	echo '{"text": "", "tooltip": "Ready to record", "class": ""}'
fi
