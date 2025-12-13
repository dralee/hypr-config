#!/bin/bash

# 批量下载音乐目录的歌词
# 使用: ./batch-download-lyrics.sh /path/to/music/folder

MUSIC_DIR="${1:-$HOME/Music}"
SCRIPT_DIR="$HOME/.config/cmus"

if [ ! -d "$MUSIC_DIR" ]; then
    echo "错误: 目录不存在 $MUSIC_DIR"
    exit 1
fi

echo "正在扫描音乐目录: $MUSIC_DIR"
echo "================================"

# 统计
total=0
success=0
skipped=0
failed=0

# 查找所有音乐文件
find "$MUSIC_DIR" -type f \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.m4a" -o -iname "*.ogg" \) | while read -r file; do
    total=$((total + 1))
    
    # 检查是否已有歌词
    lrc_file="${file%.*}.lrc"
    if [ -f "$lrc_file" ]; then
        echo "⊳ 跳过 (已有歌词): $(basename "$file")"
        skipped=$((skipped + 1))
        continue
    fi
    
    # 提取歌曲信息
    artist=$(ffprobe -v error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 "$file" 2>/dev/null)
    title=$(ffprobe -v error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 "$file" 2>/dev/null)
    
    if [ -z "$artist" ] || [ -z "$title" ]; then
        echo "✗ 跳过 (缺少标签): $(basename "$file")"
        skipped=$((skipped + 1))
        continue
    fi
    
    echo "→ 下载: $artist - $title"
    
    # 使用 Python 脚本下载
    if python3 "$SCRIPT_DIR/download-single-lyric.py" "$artist" "$title" "$file"; then
        success=$((success + 1))
        echo "  ✓ 成功"
    else
        failed=$((failed + 1))
        echo "  ✗ 失败"
    fi
    
    # 避免请求过快
    sleep 1
done

echo ""
echo "================================"
echo "完成统计:"
echo "  总计: $total"
echo "  成功: $success"
echo "  跳过: $skipped"
echo "  失败: $failed"
