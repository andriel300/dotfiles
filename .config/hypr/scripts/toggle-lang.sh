#!/usr/bin/env bash

ROFI_THEME="$HOME/.config/rofi/config-short.rasi"
ZPROFILE="$HOME/.zprofile"

# Menu via Rofi
CHOICE=$(echo -e "🇺🇸 English\n🇧🇷 Português" | rofi -dmenu -theme "$ROFI_THEME" -p "Escolha o idioma")

set_language() {
	LANG_VALUE="$1"
	LANGUAGE_SHORT="$2"

	# Atualiza /etc/locale.conf (idioma do sistema)
	echo "LANG=$LANG_VALUE" | sudo tee /etc/locale.conf >/dev/null
	export LANG="$LANG_VALUE"
	sudo locale-gen

	# Atualiza ~/.zprofile com LANG, LANGUAGE e LC_ALL
	for VAR in LANG LC_ALL LANGUAGE; do
		VALUE=$LANG_VALUE
		[[ "$VAR" == "LANGUAGE" ]] && VALUE=$LANGUAGE_SHORT

		if grep -q "^export $VAR=" "$ZPROFILE"; then
			sed -i "s|^export $VAR=.*|export $VAR=$VALUE|" "$ZPROFILE"
		else
			echo "export $VAR=$VALUE" >>"$ZPROFILE"
		fi

		export "$VAR"="$VALUE"
	done

	# Reinicia swaync e waybar com o novo idioma
	pkill -9 swaync waybar &>/dev/null
	LANG=$LANG_VALUE swaync &
	LANG=$LANG_VALUE waybar &

	# Notificação
	if [[ "$LANG_VALUE" == "pt_BR.UTF-8" ]]; then
		notify-send "🌍 Idioma alterado" "Sistema agora em Português 🇧🇷"
	else
		notify-send "🌍 Language switched" "System now in English 🇺🇸"
	fi
}

case "$CHOICE" in
"🇧🇷 Português")
	set_language "pt_BR.UTF-8" "pt_BR"
	;;
"🇺🇸 English")
	set_language "en_US.UTF-8" "en_US"
	;;
*)
	exit 0
	;;
esac
