"""
公共配置
2026.8.2 by dralee
"""
import os
from pathlib import Path

LYRICS_DIR = os.path.expanduser("~/d/data/music/Lyric")     # 歌词目录，下载路径
SAME_LRC_DIR_NAME = 'lrc'                                   # 同目录下的歌词目录

class MusicLrc:
    def __init__(self):
        self.lrc_root = Path(LYRICS_DIR)

    def same_lrc(self, music_file:str):
        """同目录下的歌词目录

        Args:
            music_file (str): 音乐文件路径

        Returns:
            lrc: 歌词文件, 不存在返回 None        
        """
        music_path = Path(music_file)
        if not music_path.exists():
            return None
        
        lrc_dir = music_path.parent / SAME_LRC_DIR_NAME
        if not lrc_dir.exists():
            return None
        
        lrc = (lrc_dir / music_path.stem).with_suffix('.lrc')

        if not lrc.exists():
            return None
        
        return lrc

    def save_lyrics(self, lyrics, music_file:str):
        """保存歌词文件"""
        if not lyrics or not music_file:
            return False

        music_path = Path(music_file)
        lrc_root = Path(LYRICS_DIR)
        lrc_root.mkdir(parents=True, exist_ok=True)        
        lrc_path = (lrc_root / music_path.stem).with_suffix('.lrc')

        try:
            with open(lrc_path, 'w', encoding='utf-8') as f:
                f.write(lyrics)
            print(f"✓ 歌词已保存: {lrc_path}")
            return True
        except Exception as e:
            print(f"保存失败: {e}")
            return False

