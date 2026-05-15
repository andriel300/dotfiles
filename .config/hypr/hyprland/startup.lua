local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"

hl.on("hyprland.start", function()
    hl.exec_cmd(scripts .. "/play-sound.sh login")

    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")

    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("udiskie --no-automount --smart-tray")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
    -- hl.exec_cmd("hyprpm reload -n")

    hl.exec_cmd(scripts .. "/hyprsocket.sh")
    hl.exec_cmd(scripts .. "/cleanup.sh")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- hl.exec_cmd("dunst")
    hl.exec_cmd("swww-daemon")
    -- hl.exec_cmd("hyprpanel")

    -- Autostart apps
    -- hl.exec_cmd("zen-browser", { workspace = "1 silent" })
    hl.exec_cmd("vesktop", { workspace = "2 silent" })
    hl.exec_cmd("steam",   { workspace = "3 silent" })
    -- hl.exec_cmd("firefox", { workspace = "4 silent" })
end)
