#!/bin/bash
# 获取所有设备的磁盘 I/O 数据并计算合计 (每秒刷新一次)
# 2026.7.22 by dralee

PREV=$(cat /tmp/disk_io_prev 2>/dev/null)
NOW=$(cat /proc/diskstats | awk '{sum_read+=$6; sum_write+=$10} END {print sum_read*512 " " sum_write*512}')

ICON="" # nf-floppy-o

echo $NOW > /tmp/disk_io_prev

if [ -z "$PREV" ]; then
    echo "R: 0KB/s W: 0KB/s"
    exit 0
fi

read -r prev_read prev_write <<< "$PREV"
read -r now_read now_write <<< "$NOW"

diff_read=$((now_read - prev_read))
diff_write=$((now_write - prev_write))

# 转换函数
convert_rate() {
    local bytes=$1
    if (( bytes > 1024*1024*1024 )); then
        echo "$(awk -v bytes=$bytes 'BEGIN {printf "%.0f",bytes/1073741824}')GB/s"
    elif (( bytes > 1024*1024 )); then
        echo "$(awk -v bytes=$bytes 'BEGIN {printf "%.0f",bytes/1048576}')MB/s"
    else
        echo "$(awk -v bytes=$bytes 'BEGIN {printf "%.0f",bytes/1024}')KB/s"
    fi
}

function disk_status(){
    INFOS=$(df -h | df -h | awk 'BEGIN{printf "Available\\t\\t\\t\\t\\tMounted"}$1 ~ /\/dev\//{printf "\\n%s\\t\\t%s",$2"-"$3"="$4"("100-$5"%)", $6}')
    echo $INFOS
}

read_speed=$(convert_rate $diff_read)
write_speed=$(convert_rate $diff_write)
tooltip_text=$(disk_status)

out_data="{\"text\": \"${ICON}  ${read_speed} / ${write_speed}\",\"alt\": \"Disk\",\"tooltip\": \"$tooltip_text\",\"class\": \"default\"}"

echo $out_data
