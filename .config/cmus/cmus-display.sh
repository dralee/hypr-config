
#!/bin/bash

# cmus 音乐可视化启动脚本
# 使用 kitty 分屏显示 cmus、歌词和波形

# 检查 cmus 是否运行
if ! pgrep -x "cmus" > /dev/null; then
    # 启动新的 kitty 窗口，使用 kitty 的布局功能
    kitty --class cmus-player \
        -o initial_window_width=1920 \
        -o initial_window_height=1080 \
        --session ~/.config/kitty/cmus-session.conf &
else
    echo "cmus 已在运行"
fi
