-- auto run app for default

hl.on("hyprland.start", function ()
    -- -------------------------------------------------------------------------------------------
    -- system environment
    -- -------------------------------------------------------------------------------------------
    -- fcitx5
    hl.exec_cmd("fcitx5 -d --replace")
    -- waybar
    hl.exec_cmd("waybar")
    -- dunst
    hl.exec_cmd("dunst")
    -- awww
    hl.exec_cmd("awww-daemon")
    -- wl-paste clipboard
    hl.exec_cmd("wl-paste -t text -w xclip -selection clipboard --watch cliphist store")
    -- wl-paste text
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    -- wl-paste image
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    -- share
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    -- xdg
    hl.exec_cmd("$HOME/.config/hypr/scripts/xdg-desktop-portal.sh")

    -- -------------------------------------------------------------------------------------------
    -- custom app start
    -- -------------------------------------------------------------------------------------------
    -- usb
    hl.exec_cmd("udiskie &")
    -- network connect mgr
    hl.exec_cmd("nm-applet")
    -- hypridle
    hl.exec_cmd("hypridle")
    -- typora
    hl.exec_cmd("$HOME/Application/Typora-linux-x64/Typora --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime")
    -- qq
    hl.exec_cmd("$HOME/Application/QQ.AppImage --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime")
    -- wechat
    hl.exec_cmd("/usr/bin/wechat %u")
    -- feishu
    hl.exec_cmd("/usr/bin/feishu --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime %U")
    -- awww wallpapers
    hl.exec_cmd("awww img \"$HOME/.config/wallpapers/126901-ocean.jpg\"")
    -- dbus monitors
    hl.exec_cmd("$HOME/.config/hypr/scripts/dbus-monitor/dbus-notification-monitor-linux-amd64 -c $HOME/.config/hypr/scripts/dbus-monitor/notification-monitor.conf")

end)
