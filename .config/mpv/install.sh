#!/bin/bash
# 检测mpv的lua环境，并安装依赖
# 2025.4.2 by dralee
#

mpv_config=$HOME/.config/mpv

# 由于mpv版本为luajit即5.1，需要安装为该版本的依赖
init_env(){
	sudo pacman -S luarocks
}
init_deps(){
	luarocks --lua-version=5.1 install lua-cjson
	luarocks --lua-version=5.1 install md5
}
show_deps(){
	luarocks list --lua-version=5.1
}
init_config(){
	mkdir -p $mpv_config	
	cp ./mpv.conf $mpv_config
}
init_scripts(){
	mkdir -p $mpv_config	
	cp ./scripts $mpv_config -r
}
mpv_init(){
	read -p "convert the mpv config?(Y/y):" confirm
	#echo $confirm
	if [[ $confirm =~ ^(Y|y)$ ]];then
		init_config
	else
		echo no
	fi

	init_scripts
	echo mpv config init successfully.
}

count=`sudo pacman -Qs luarocks | wc -l`
if [ $count -eq 0 ];then
	echo not luarocks env.
	init_env
else
	echo env is ok for luarocks.
fi

#init_deps

#show_deps

mpv_init
