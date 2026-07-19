#!/usr/bin/env python3
"""
cmus 歌词显示脚本
保存到 ~/.config/cmus/show_lyrics.py
"""

import subprocess
import os
import sys
import time
from pathlib import Path

def get_cmus_status():
    """获取 cmus 当前播放状态"""
    try:
        result = subprocess.run(['cmus-remote', '-Q'],
                              capture_output=True,
                              text=True,
                              timeout=2)
        if result.returncode != 0:
            return None

        info = {}
        for line in result.stdout.split('\n'):
            if line.startswith('tag'):
                parts = line.split(' ', 2)
                if len(parts) == 3:
                    info[parts[1]] = parts[2]
            elif line.startswith('file'):
                info['file'] = line.split(' ', 1)[1]
            elif line.startswith('status'):
                info['status'] = line.split(' ', 1)[1]
            elif line.startswith('position'):
                info['position'] = int(line.split(' ', 1)[1])
            elif line.startswith('duration'):
                info['duration'] = int(line.split(' ', 1)[1])

        return info
    except Exception as e:
        return None

def find_lyrics(music_file, artist, title):
    """查找歌词文件"""
    if not music_file:
        return None

    music_path = Path(music_file)
    music_dir = music_path.parent
    base_name = music_path.stem

    # 可能的歌词文件位置
    lrc_files = [
        music_dir / f"{base_name}.lrc",
        music_dir / f"{artist} - {title}.lrc",
        Path.home() / ".lyrics" / f"{artist} - {title}.lrc",
    ]

    for lrc_file in lrc_files:
        if lrc_file.exists():
            return lrc_file

    return None

def parse_lrc(lrc_file):
    """解析 LRC 歌词文件"""
    lyrics = []
    try:
        with open(lrc_file, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if line.startswith('[') and ']' in line:
                    # 解析时间标签 [mm:ss.xx]
                    time_tag = line[1:line.index(']')]
                    text = line[line.index(']')+1:]

                    if ':' in time_tag:
                        try:
                            parts = time_tag.split(':')
                            minutes = int(parts[0])
                            seconds = float(parts[1])
                            timestamp = minutes * 60 + seconds
                            lyrics.append((timestamp, text))
                        except:
                            pass

        lyrics.sort(key=lambda x: x[0])
        return lyrics
    except Exception as e:
        return []

def display_lyrics(lyrics, position):
    """显示当前歌词"""
    os.system('clear')

    if not lyrics:
        print("\n\n \033[31m 🎵 未找到歌词文件\033[0m\n") # red
        print("  请将 .lrc 文件放在音乐文件同目录下")
        return

    # 找到当前歌词位置
    current_idx = 0
    for i, (timestamp, text) in enumerate(lyrics):
        if timestamp <= position:
            current_idx = i
        else:
            break

    # 显示上下文歌词
    print("\n" + "="*60)
    print("  \033[34m🎵\033[0m \033[34m歌词显示\033[0m") # blue
    print("="*60 + "\n")

    start = max(0, current_idx - 3)
    end = min(len(lyrics), current_idx + 5)

    for i in range(start, end):
        timestamp, text = lyrics[i]
        if i == current_idx:
            print(f"  \033[31m►\033[0m \033[36m{text}\033[0m") # cyan
        else:
            print(f"    {text}")

    print("\n" + "="*60)

def main():
    """主循环"""
    last_file = None
    lyrics = []

    while True:
        status = get_cmus_status()

        if not status:
            print("\r \033[31m ⏸  cmus 未运行或未播放\033[0m", end='',flush=True) # red
            time.sleep(2)
            continue

        if status.get('status') != 'playing':
            print("\r ⏸  已暂停",end='',flush=True)
            time.sleep(1)
            continue

        # 如果歌曲改变，重新加载歌词
        current_file = status.get('file')
        if current_file != last_file:
            last_file = current_file
            artist = status.get('artist', 'Unknown')
            title = status.get('title', 'Unknown')

            lrc_file = find_lyrics(current_file, artist, title)
            if lrc_file:
                lyrics = parse_lrc(lrc_file)
            else:
                lyrics = []

        # 显示歌词
        position = status.get('position', 0)
        display_lyrics(lyrics, position)

        time.sleep(0.5)

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print("\n退出歌词显示")
        sys.exit(0)
