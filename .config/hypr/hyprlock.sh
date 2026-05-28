#!/bin/bash
# 2026.2.9 add the dbus notify by dralee

# clean the old log
bash ~/.config/hypr/scripts/dbus-monitor/notify.sh Y
python ~/.config/hypr/scripts/poem/poem_show.py
hyprlock
