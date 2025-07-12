#!/bin/bash
# auto install the GreatVibes font for geek_word show
# 2025.7.4 by dralee

sudo cp ./fonts/GreatVibes-Regular.ttf /usr/share/fonts/
sudo mkdir -p /usr/share/fonts/WindowsFonts && sudo cp ./fonts/STXINGKA.TTF /usr/share/fonts/WindowsFonts  # 行楷体for poem
fc-cache -vf
