#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme="config"
# run

rofi \
	-show drun \
	-theme ${dir}/${theme}.rasi
