#!/usr/bin/env python3
"""
自动下载歌词脚本 - 支持网易云音乐API
保存到 ~/.config/cmus/auto-download-lyrics.py
"""

import requests
import json
import os
import sys
from pathlib import Path
import subprocess

def get_cmus_current():
    """获取 cmus 当前播放信息"""
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

        return info
    except:
        return None

def search_netease(artist, title):
    """从网易云音乐搜索歌曲"""
    url = "http://music.163.com/api/search/get/web"
    params = {
        's': f"{artist} {title}",
        'type': 1,
        'offset': 0,
        'limit': 5
    }

    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        'Referer': 'http://music.163.com/'
    }

    try:
        response = requests.get(url, params=params, headers=headers, timeout=10)
        data = response.json()

        if data['code'] == 200 and data['result']['songCount'] > 0:
            return data['result']['songs'][0]['id']
    except Exception as e:
        print(f"搜索失败: {e}")

    return None

def get_netease_lyrics(song_id):
    """获取网易云音乐歌词"""
    url = f"http://music.163.com/api/song/lyric"
    params = {
        'id': song_id,
        'lv': 1,
        'kv': 1,
        'tv': -1
    }

    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        'Referer': 'http://music.163.com/'
    }

    try:
        response = requests.get(url, params=params, headers=headers, timeout=10)
        data = response.json()

        # 优先使用滚动歌词
        if 'lrc' in data and 'lyric' in data['lrc']:
            return data['lrc']['lyric']
    except Exception as e:
        print(f"获取歌词失败: {e}")

    return None

def download_from_lrclib(artist, title):
    """从 lrclib.net 下载歌词（免费API）"""
    url = "https://lrclib.net/api/search"
    params = {
        'artist_name': artist,
        'track_name': title
    }

    try:
        response = requests.get(url, params=params, timeout=10)
        if response.status_code == 200:
            results = response.json()
            if results and len(results) > 0:
                # 返回第一个匹配的同步歌词
                if 'syncedLyrics' in results[0] and results[0]['syncedLyrics']:
                    return results[0]['syncedLyrics']
    except Exception as e:
        print(f"lrclib.net 获取失败: {e}")

    return None

def save_lyrics(lyrics, music_file):
    """保存歌词文件"""
    if not lyrics or not music_file:
        return False

    music_path = Path(music_file)
    lrc_path = music_path.with_suffix('.lrc')

    try:
        with open(lrc_path, 'w', encoding='utf-8') as f:
            f.write(lyrics)
        print(f"✓ 歌词已保存: {lrc_path}")
        return True
    except Exception as e:
        print(f"保存失败: {e}")
        return False

def main():
    """主函数"""
    # 获取当前播放信息
    info = get_cmus_current()

    if not info:
        print("✗ cmus 未运行或未播放")
        sys.exit(1)

    artist = info.get('artist', '')
    title = info.get('title', '')
    music_file = info.get('file', '')

    if not artist or not title:
        print("✗ 缺少歌手或歌曲信息")
        sys.exit(1)

    # 检查是否已有歌词
    lrc_path = Path(music_file).with_suffix('.lrc')
    if lrc_path.exists():
        print(f"✓ 歌词文件已存在: {lrc_path}")
        sys.exit(0)

    print(f"正在搜索歌词: {artist} - {title}")

    # 方案1: 尝试 lrclib.net
    print("尝试 lrclib.net ...")
    lyrics = download_from_lrclib(artist, title)

    # 方案2: 尝试网易云音乐
    if not lyrics:
        print("尝试网易云音乐 ...")
        song_id = search_netease(artist, title)
        if song_id:
            lyrics = get_netease_lyrics(song_id)

    # 保存歌词
    if lyrics:
        if save_lyrics(lyrics, music_file):
            print("✓ 歌词下载成功！")
            sys.exit(0)
        else:
            print("✗ 歌词保存失败")
            sys.exit(1)
    else:
        print("✗ 未找到歌词")
        sys.exit(1)

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print("\n已取消")
        sys.exit(0)
