-- auto run app for work run environment

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

-- dbus monitors
hl.exec_cmd("$HOME/.config/hypr/scripts/dbus-monitor/dbus-notification-monitor-linux-amd64 -c $HOME/.config/hypr/scripts/dbus-monitor/notification-monitor.conf")