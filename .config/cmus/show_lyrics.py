#!/usr/bin/env python3
"""
cmus 歌词显示脚本 - 支持自动检测歌词文件更新
保存到 ~/.config/cmus/show_lyrics.py
"""

import subprocess
import os
import sys
import time
from pathlib import Path

from common import MusicLrc

# 全局变量存储文件监控信息
last_file = None
last_lyrics = []
last_lrc_mtime = 0

music_lrc = MusicLrc()

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
        music_lrc.lrc_root / f"{base_name}.lrc",
        music_dir / f"{base_name}.lrc",
        music_dir / f"{artist} - {title}.lrc",
        Path.home() / ".lyrics" / f"{artist} - {title}.lrc",
    ]

    lrc_file = music_lrc.same_lrc(music_file)
    if lrc_file:
        lrc_files.append(lrc_file)

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

def check_lyrics_updated(lrc_file):
    """检查歌词文件是否已更新"""
    global last_lrc_mtime

    if not lrc_file or not lrc_file.exists():
        return False

    try:
        current_mtime = lrc_file.stat().st_mtime
        if current_mtime > last_lrc_mtime:
            last_lrc_mtime = current_mtime
            return True
    except:
        pass

    return False

def display_lyrics(lyrics, position, status_info):
    """显示当前歌词"""
    os.system('clear')

    # 显示歌曲信息头部
    artist = status_info.get('artist', 'Unknown Artist')
    title = status_info.get('title', 'Unknown Title')
    album = status_info.get('album', '')

    print("\n" + "="*70)
    print(f"  🎵 {artist} - {title}")
    if album:
        print(f"  💿 {album}")
    print("="*70 + "\n")

    if not lyrics:
        print("  📝 未找到歌词文件")
        print("  💡 提示：按 'd' 键自动下载歌词\n")
        print("  歌词文件应命名为：")
        print(f"     {Path(status_info.get('file', '')).stem}.lrc")
        print(f"  或保存在音乐文件同目录下\n")
        return

    # 找到当前歌词位置
    current_idx = 0
    for i, (timestamp, text) in enumerate(lyrics):
        if timestamp <= position:
            current_idx = i
        else:
            break

    # 显示上下文歌词 (当前行前3行，后4行)
    start = max(0, current_idx - 3)
    end = min(len(lyrics), current_idx + 5)

    for i in range(start, end):
        timestamp, text = lyrics[i]

        # 格式化时间
        mins = int(timestamp // 60)
        secs = int(timestamp % 60)
        time_str = f"[{mins:02d}:{secs:02d}]"

        if i == current_idx:
            # 当前播放行 - 高亮显示
            print(f" \033[33m ►\033[0m {time_str} \033[1;36m{text}\033[0m")
        elif i == current_idx + 1:
            # 下一行 - 次要高亮
            print(f"    {time_str} \033[0;37m{text}\033[0m")
        else:
            # 其他行 - 暗色
            print(f"    {time_str} \033[0;90m{text}\033[0m")

    # 显示进度条
    duration = status_info.get('duration', 0)
    if duration > 0:
        progress = position / duration
        bar_length = 60
        filled = int(bar_length * progress)
        bar = "█" * filled + "░" * (bar_length - filled)

        pos_min = int(position // 60)
        pos_sec = int(position % 60)
        dur_min = int(duration // 60)
        dur_sec = int(duration % 60)

        print(f"\n  {bar}")
        print(f"  {pos_min:02d}:{pos_sec:02d} / {dur_min:02d}:{dur_sec:02d}")

    print("\n" + "="*70)
    print("  💡 按 'd' 下载歌词 | 按 'q' 退出歌词显示")
    print("="*70)

def main():
    """主循环"""
    global last_file, last_lyrics, last_lrc_mtime

    print("\n\n  正在启动歌词显示...\n  等待 cmus 播放音乐...\n")
    time.sleep(1)

    while True:
        status = get_cmus_status()

        if not status:
            os.system('clear')
            print("\r  ⏸  cmus 未运行或未播放",end='',flush=True)
            print("\n\r  请先启动 cmus 并播放音乐",end='',flush=True)
            time.sleep(2)
            last_file = None
            last_lyrics = []
            last_lrc_mtime = 0
            continue

        if status.get('status') != 'playing':
            os.system('clear')
            print("\r  ⏸  已暂停", end='',flush=True)
            time.sleep(1)
            continue

        # 获取当前歌曲信息
        current_file = status.get('file')
        artist = status.get('artist', 'Unknown')
        title = status.get('title', 'Unknown')

        # 如果歌曲改变或歌词文件更新，重新加载歌词
        lrc_file = find_lyrics(current_file, artist, title)

        if current_file != last_file:
            # 歌曲改变
            last_file = current_file
            last_lrc_mtime = 0

            if lrc_file and lrc_file.exists():
                last_lyrics = parse_lrc(lrc_file)
                last_lrc_mtime = lrc_file.stat().st_mtime
            else:
                last_lyrics = []

        elif lrc_file and check_lyrics_updated(lrc_file):
            # 歌词文件被更新（例如刚下载完成）
            last_lyrics = parse_lrc(lrc_file)
            # 显示提示
            os.system('clear')
            print("\n\n  ✓ 歌词已更新！\n")
            time.sleep(1)

        # 显示歌词
        position = status.get('position', 0)
        display_lyrics(last_lyrics, position, status)

        # 刷新频率
        time.sleep(0.3)

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        os.system('clear')
        print("\n  退出歌词显示\n")
        sys.exit(0)
