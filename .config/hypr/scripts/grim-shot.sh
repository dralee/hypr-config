#!/bin/bash
# 获取活动窗口的几何信息（不包含边框）
WINDOW=$(hyprctl activewindow -j)
X=$(echo $WINDOW | jq -r '.at[0]')
Y=$(echo $WINDOW | jq -r '.at[1]')
W=$(echo $WINDOW | jq -r '.size[0]')
H=$(echo $WINDOW | jq -r '.size[1]')

# 截取该区域
grim -g "${X},${Y} ${W}x${H}" - | wl-copy
