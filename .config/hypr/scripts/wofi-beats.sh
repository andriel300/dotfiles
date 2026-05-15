#!/bin/bash

# 🛠 Configurações
THEME="${ROFI_THEME:-$HOME/.config/rofi/kool-config.rasi}"
PID_FILE="/tmp/radio-mpv.pid"
HISTORY_FILE="$HOME/.cache/rofi_music_history"
ICON_DIR="$HOME/.config/rofi/music/"
MUSIC_DIR="$HOME/Music"
mkdir -p "$(dirname "$HISTORY_FILE")"

# 🔊 Notificação
notification() {
	notify-send -u normal -i "$ICON_DIR/music.png" "🎵 Now Playing" "$@"
}

# 🎧 Rádios Online
declare -A online_music=(
	["FM - Easy Rock 96.3 📻🎶"]="https://radio-stations-philippines.com/easy-rock"
	["FM - Easy Rock - Baguio 91.9 📻🎶"]="https://radio-stations-philippines.com/easy-rock-baguio"
	["FM - Love Radio 90.7 📻🎶"]="https://radio-stations-philippines.com/love"
	["FM - WRock - CEBU 96.3 📻🎶"]="https://onlineradio.ph/126-96-3-wrock.html"
	["FM - Fresh Philippines 📻🎶"]="https://onlineradio.ph/553-fresh-fm.html"
	["Radio - Lofi Girl 🎧🎶"]="https://play.streamafrica.net/lofiradio"
	["Radio - Chillhop 🎧🎶"]="http://stream.zeno.fm/fyn8eh3h5f8uv"
	["Radio - Ibiza Global 🎧🎶"]="https://filtermusic.net/ibiza-global"
	["Radio - Metal Music 🎧🎶"]="https://tunein.com/radio/mETaLmuSicRaDio-s119867/"
	["YT - Wish 107.5 YT Pinoy HipHop 📻🎶"]="https://youtube.com/playlist?list=PLkrzfEDjeYJnmgMYwCKid4XIFqUKBVWEs&si=vahW_noh4UDJ5d37"
	["YT - Youtube Top 100 Songs Global 📹🎶"]="https://youtube.com/playlist?list=PL4fGSI1pDJn6puJdseH2Rt9sMvt9E2M4i&si=5jsyfqcoUXBCSLeu"
	["YT - Wish 107.5 YT Wishclusives 📹🎶"]="https://youtube.com/playlist?list=PLkrzfEDjeYJn5B22H9HOWP3Kxxs-DkPSM&si=d_Ld2OKhGvpH48WO"
	["YT - Relaxing Piano Music 🎹🎶"]="https://youtu.be/6H7hXzjFoVU?si=nZTPREC9lnK1JJUG"
	["YT - Youtube Remix 📹🎶"]="https://youtube.com/playlist?list=PLeqTkIUlrZXlSNn3tcXAa-zbo95j0iN-0"
	["YT - Korean Drama OST 📹🎶"]="https://youtube.com/playlist?list=PLUge_o9AIFp4HuA-A3e3ZqENh63LuRRlQ"
	["YT - Relaxing Piano Jazz Music 🎹🎶"]="https://youtu.be/85UEqRat6E4?si=jXQL1Yp2VP_G6NSn"
	["YT - Lofi Girl ☕️"]="https://www.youtube.com/watch?v=jfKfPfyJRdk"
	["YT - Chillhop ☕️"]="https://www.youtube.com/watch?v=5yx6BWlEVcY"
	["YT - Smooth Chill 💆"]="https://www.youtube.com/watch?v=lTRiuFIWV54"
	["YT - Rain Sounds 🌧️"]="https://www.youtube.com/watch?v=mPZkdNFkNps"
	["YT - Brown Sounds 🌪️"]="https://www.youtube.com/watch?v=0GDfOAuUvQ0"
	["YT - Fireplace 🔥"]="https://www.youtube.com/watch?v=eyU3bRy2x44"
	["YT - Forest Sounds 🌲"]="https://www.youtube.com/watch?v=OdIJ2x3nxzQ"
)

# 🎼 Preenche lista de músicas locais
populate_local_music() {
	local_music=()
	filenames=()
	while IFS= read -r file; do
		local_music+=("$file")
		filenames+=("$(basename "$file")")
	done < <(find "$MUSIC_DIR" -type f \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.ogg" \))
}

# 📜 Salva histórico
save_history() {
	echo "$1" >>"$HISTORY_FILE"
	tail -n 15 "$HISTORY_FILE" >"$HISTORY_FILE.tmp" && mv "$HISTORY_FILE.tmp" "$HISTORY_FILE"
}

# ▶️ Player
play_stream() {
	local url="$1"
	local title="$2"
	mpv --no-video --volume=60 --title="radio-mpv" --ytdl --loop-playlist "$url" &>/dev/null &
	echo "$!" >"$PID_FILE"
	save_history "$title"
	notification "$title"
}

# 🎶 Play música local
play_local_music() {
	populate_local_music
	choice=$(printf "%s\n" "${filenames[@]}" | wofi --show dmenu --prompt "🎵 Escolha uma música" --insensitive)
	[[ -z "$choice" ]] && exit 1

	for i in "${!filenames[@]}"; do
		if [[ "${filenames[$i]}" == "$choice" ]]; then
			notification "$choice"
			mpv --playlist-start="$i" --loop-playlist --no-video "${local_music[@]}"
			break
		fi
	done
}

# 🔀 Shuffle local
shuffle_local_music() {
	notification "🔀 Shuffle local"
	mpv --shuffle --loop-playlist --no-video "$MUSIC_DIR"
}

# 📜 Ver histórico
show_history() {
	[ ! -f "$HISTORY_FILE" ] && echo "Nenhum histórico encontrado" && return
	wofi --show dmenu --prompt "🕘 Últimos tocados" --insensitive <"$HISTORY_FILE"
}

# 🎛 Menu principal
main_menu() {
	printf "🎧 Online Music\n"
	printf "🎵 Local Music\n"
	printf "🔀 Shuffle Local\n"
	printf "🕘 History\n"
	printf "❌ Stop & Exit\n"
}

# 🧠 Lógica principal
main() {
	choice=$(main_menu | wofi --show dmenu --prompt "🎶 Beats" --insensitive)

	# Para música atual
	if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
		pkill -f "radio-mpv" && rm -f "$PID_FILE"
	fi

	case "$choice" in
	"🎧 Online Music")
		stream=$(printf "%s\n" "${!online_music[@]}" | sort | wofi --show dmenu --prompt "📻 Online Radios" --insensitive)
		[[ -z "$stream" ]] && exit 0
		play_stream "${online_music[$stream]}" "$stream"
		;;
	"🎵 Local Music") play_local_music ;;
	"🔀 Shuffle Local") shuffle_local_music ;;
	"🕘 History") show_history ;;
	"❌ Stop & Exit") notification "Música parada 👋" && exit 0 ;;
	*) notification "Opção inválida ❌" && exit 1 ;;
	esac
}

# 🧪 Verifica dependências
for cmd in mpv wofi notify-send; do
	command -v "$cmd" &>/dev/null || {
		echo "Erro: '$cmd' não encontrado"
		exit 1
	}
done

main
