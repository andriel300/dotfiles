#!/bin/bash

SOUND_DIR="/home/diel/Music/Saved Audio/Harmony"
MACOS_DIR="/home/diel/Music/Saved Audio/macOS Big Sur Sounds"

case "$1" in
    login)          pw-play --volume 0.5 "$SOUND_DIR/desktop-login.ogg" ;;
    logout)         pw-play --volume 0.5 "$SOUND_DIR/desktop-logout.ogg" ;;
    lock)           pw-play --volume 0.5 "$SOUND_DIR/desktop-screen-lock.ogg" ;;
    unlock)         pw-play --volume 0.5 "$SOUND_DIR/desktop-screen-unlock.ogg" ;;
    
    volume-up)      pw-play --volume 0.3 "$SOUND_DIR/audio-volume-change.ogg" ;;
    volume-down)    pw-play --volume 0.3 "$SOUND_DIR/audio-volume-change.ogg" ;;
    volume-mute)    pw-play --volume 0.3 "$SOUND_DIR/audio-volume-change.ogg" ;;
    
    screenshot)     pw-play --volume 0.5 "$SOUND_DIR/camera-shutter.ogg" ;;
    window-close)   pw-play --volume 0.3 "$SOUND_DIR/window-close.ogg" ;;
    window-open)    pw-play --volume 0.3 "$SOUND_DIR/window-new.ogg" ;;
    error)          pw-play --volume 0.5 "$SOUND_DIR/dialog-error-critical.ogg" ;;
    warning)        pw-play --volume 0.5 "$SOUND_DIR/dialog-warning.ogg" ;;
    complete)       pw-play --volume 0.5 "$SOUND_DIR/complete-copy.ogg" ;;
    trash)          pw-play --volume 0.5 "$SOUND_DIR/trash-empty.ogg" ;;
    device)         pw-play --volume 0.5 "$SOUND_DIR/device-added.ogg" ;;
    
    terminal)       pw-play --volume 0.5 "$SOUND_DIR/button-pressed.ogg" ;;
    menu)           pw-play --volume 0.5 "$SOUND_DIR/button-pressed.ogg" ;;
    toggle-on)      pw-play --volume 0.5 "$SOUND_DIR/button-toggle-on.ogg" ;;
    toggle-off)     pw-play --volume 0.5 "$SOUND_DIR/button-toggle-off.ogg" ;;
    
    # macOS Big Sur Sounds
    macos-pop)      pw-play --volume 0.5 "$MACOS_DIR/Pop.wav" ;;
    macos-ping)     pw-play --volume 0.5 "$MACOS_DIR/Ping.wav" ;;
    macos-glass)    pw-play --volume 0.5 "$MACOS_DIR/Glass.wav" ;;
    macos-hero)     pw-play --volume 0.5 "$MACOS_DIR/Hero.wav" ;;
    macos-basso)    pw-play --volume 0.5 "$MACOS_DIR/Basso.wav" ;;
    macos-blow)     pw-play --volume 0.5 "$MACOS_DIR/Blow.wav" ;;
    macos-bottle)   pw-play --volume 0.5 "$MACOS_DIR/Bottle.wav" ;;
    macos-frog)     pw-play --volume 0.5 "$MACOS_DIR/Frog.wav" ;;
    macos-funk)     pw-play --volume 0.5 "$MACOS_DIR/Funk.wav" ;;
    macos-morse)    pw-play --volume 0.5 "$MACOS_DIR/Morse.wav" ;;
    macos-purr)     pw-play --volume 0.5 "$MACOS_DIR/Purr.wav" ;;
    macos-sosumi)   pw-play --volume 0.5 "$MACOS_DIR/Sosumi.wav" ;;
    macos-submarine)pw-play --volume 0.5 "$MACOS_DIR/Submarine.wav" ;;
    macos-tink)     pw-play --volume 0.5 "$MACOS_DIR/Tink.wav" ;;
    macos-startup)  pw-play --volume 0.7 "$MACOS_DIR/Startup Chime.wav" ;;
    macos-volume)   pw-play --volume 0.5 "$MACOS_DIR/Volume_Mount.wav" ;;
    
    *)
                  echo "Usage: $0 {login|logout|lock|unlock|volume-up|volume-down|volume-mute|screenshot|window-close|window-open|error|warning|complete|trash|device|terminal|menu|toggle-on|toggle-off}"
                  echo ""
                  echo "macOS Big Sur: macos-pop|macos-ping|macos-glass|macos-hero|macos-basso|macos-blow|macos-bottle|macos-frog|macos-funk|macos-morse|macos-purr|macos-sosumi|macos-submarine|macos-tink|macos-startup|macos-volume"
                  exit 1
                  ;;
esac
