#!/usr/bin/env python3
"""
简单的歌词下载工具
使用: python3 download-single-lyric.py "artist" "title" "output.lrc"
"""

import sys
import requests
from pathlib import Path

def download_lyrics(artist, title, output_file=None):
    """从 lrclib.net 下载歌词"""
    url = "https://lrclib.net/api/search"
    params = {
        'artist_name': artist,
        'track_name': title
    }

    try:
        print(f"搜索: {artist} - {title}")
        response = requests.get(url, params=params, timeout=10)

        if response.status_code != 200:
            print(f"错误: HTTP {response.status_code}")
            return False

        results = response.json()

        if not results or len(results) == 0:
            print("未找到歌词")
            return False

        # 获取第一个结果
        result = results[0]
        lyrics = result.get('syncedLyrics') or result.get('plainLyrics')

        if not lyrics:
            print("歌词为空")
            return False

        # 保存歌词
        if output_file:
            output_path = Path(output_file)
        else:
            output_path = Path(f"{artist} - {title}.lrc")

        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(lyrics)

        print(f"✓ 已保存: {output_path}")
        return True

    except Exception as e:
        print(f"错误: {e}")
        return False

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("用法: python3 download-single-lyric.py <artist> <title> [output_file]")
        print("示例: python3 download-single-lyric.py '周杰伦' '七里香'")
        sys.exit(1)

    artist = sys.argv[1]
    title = sys.argv[2]
    output = sys.argv[3] if len(sys.argv) > 3 else None

    if download_lyrics(artist, title, output):
        sys.exit(0)
    else:
        sys.exit(1)
