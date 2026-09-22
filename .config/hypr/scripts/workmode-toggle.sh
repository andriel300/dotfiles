#!/usr/bin/env bash

# === Diretórios e temas ===
WALLPAPER_DIR="$HOME/github-repos/Wallpaper-Bank/wallpapers"
ZEN_WALLPAPER="$WALLPAPER_DIR/Balcony-ja.png"
# === Menu de seleção ===
MODE=$(echo -e "🎨 Rice Mode\n🧘 Zen Mode\n🎮 Game Mode" | wofi --show dmenu --prompt "Select Mode")

# === Função para trocar wallpaper ===
set_wallpaper() {
	local IMAGE="$1"
	if [[ -f "$IMAGE" ]]; then
		dms ipc call wallpaper set "$IMAGE"
	else
		notify-send -u critical "Wallpaper não encontrado" "$IMAGE"
	fi
}

# === Configurações de cada modo ===
case "$MODE" in
"🎮 Game Mode")
	hyprctl -q --batch "\
        keyword animations:enabled 0;
        keyword decoration:shadow:enabled 0;
        keyword decoration:shadow:xray 1;
        keyword decoration:blur:enabled 0;
        keyword general:gaps_in 0;
        keyword general:gaps_out 0;
        keyword general:border_size 1;
        keyword decoration:rounding 0;
        keyword decoration:active_opacity 1;
        keyword decoration:inactive_opacity 1;
        keyword decoration:fullscreen_opacity 1;
        keyword layerrule noanim,dms:bar;
        keyword layerrule noanim,quickshell;
        keyword layerrule noanim,swww-daemon;
        keyword layerrule noanim,wofi"

	hyprctl 'keyword windowrule opaque,class:(.*)'
	hyprctl keyword windowrulev2 "opacity 1.0 override 1.0 override,class:^(com.mitchellh.ghostty)$"
	hyprctl keyword windowrulev2 "opacity 1.0 override 1.0 override,class:^(zen)$"
	notify-send "🎮 GAME MODE ATIVADO" "Configurações aplicadas para performance"
	;;

"🧘 Zen Mode")
	set_wallpaper "$ZEN_WALLPAPER"

	hyprctl -q --batch "\
        keyword animations:enabled 0;
        keyword decoration:shadow:enabled 0;
        keyword decoration:shadow:xray 1;
        keyword decoration:blur:enabled 0;
        keyword general:gaps_in 5;
        keyword general:gaps_out 5;
        keyword general:border_size 1;
        keyword decoration:rounding 0;
        keyword decoration:active_opacity 1;
        keyword decoration:inactive_opacity 1;
        keyword decoration:fullscreen_opacity 1;
        keyword layerrule noanim,dms:bar;
        keyword layerrule noanim,quickshell;
        keyword layerrule noanim,swww-daemon;
        keyword layerrule noanim,wofi"

	hyprctl 'keyword windowrule opaque,class:(.*)'
	hyprctl keyword windowrulev2 "opacity 1.0 override 1.0 override,class:^(com.mitchellh.ghostty)$"
	hyprctl keyword windowrulev2 "opacity 1.0 override 1.0 override,class:^(zen)$"

	notify-send "🧘 ZEN MODE ATIVADO" "Foco para estudos ou trabalho"
	;;

"🎨 Rice Mode")
	RANDOM_WALLPAPER=$(find -L "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | shuf -n 1)
	set_wallpaper "$RANDOM_WALLPAPER"

	if hyprctl reload; then
		notify-send "🎨 RICE MODE ATIVADO" "Wallpaper: $(basename "$RANDOM_WALLPAPER")"
	else
		notify-send -u critical "Hyprland" "Erro ao aplicar Rice!"
	fi
	;;

*)
	exit 0
	;;
esac
