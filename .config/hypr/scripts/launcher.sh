#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme="style-1"
# run

rofi \
	-show drun \
	-theme ${dir}/${theme}.rasi
