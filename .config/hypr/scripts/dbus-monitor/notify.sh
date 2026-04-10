#!/bin/bash
# dbus notify for hyprlock
# just check the Feish notifiy
# 2026.2.9 by dralee
# 2026.4.10 by dralee fix the cut for Chinese show error code
# $1: Y/y to delete old log
src_file=$HOME/.config/hypr/scripts/dbus-monitor/Feishu.log
clear_it=$1

if [ ! -f "$src_file" ];then
	exit 0
fi

if [[ "$clear_it" =~ ^[Yy] ]];then
	rm $src_file
	echo clean the \"$src_file\" now
	exit 0
fi

# cut will cut part of Chinese word for error show
#line=`head -n 1 $src_file | sed 's#【Feishu】# 󱗆 #g' | cut -c 1-80`
#echo $line
line=`head -n 1 $src_file | sed 's#【Feishu】# 󱗆 #g'`
echo ${line:0:80}

