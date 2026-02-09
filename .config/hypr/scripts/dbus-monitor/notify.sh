#!/bin/bash
# dbus notify for hyprlock
# just check the Feish notifiy
# 2026.2.9 by dralee
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

line=`head -n 1 $src_file | sed 's#【Feishu】# 󱗆#g' | cut -c 1-60`
echo $line

