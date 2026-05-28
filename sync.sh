#!/bin/bash
# auto sync the local for this repository
# 2025.6.24 by dralee
# 2025.7.4 by dralee auto commit
# 2026.5.28 by dralee hyprland construct by lua
# $1: auto commit comment, if empty not auto commit

comment=$1

# dir
config_dir=.config
local_dir=.local
mozilla_dir=.mozilla
local_share_dir=$local_dir/share
hyprland_dir=$config_dir/hypr
hyprland_dir_scripts=$hyprland_dir/scripts
waybar_dir=$config_dir/waybar
mpv_dir=$config_dir/mpv
fcitx5_dir=$config_dir/fcitx5
fcitx5_conf_dir=$fcitx5_dir/conf
fcitx5_local=$local_dir/share/fcitx5
fcitx5_local_rime=$fcitx5_local/rime
fcitx5_local_rime_build=$fcitx5_local_rime/build
fcitx5_local_rime_opencc=$fcitx5_local_rime/opencc
fcitx5_local_themes=$fcitx5_local/themes
ranger_dir=$config_dir/ranger
rofi_dir=$config_dir/rofi
typora_dir=$config_dir/Typora
typora_themes_dir=$typora_dir/themes
wlogout_dir=$config_dir/wlogout
wofi_dir=$config_dir/wofi
vim_dir=.vim
etc_dir=/etc
usr_dir=/usr
firefox_default_chrome=$mozilla_dir/firefox/71ul370y.default-release/chrome
yazi_dir=$config_dir/yazi

# file
#hyprland_config=$hyprland_dir/hyprland.conf
#hyprland_custom=$hyprland_dir/custom
#hyprland_config_work=$hyprland_dir/hyprland-work.conf
#hyprland_custom_work=$hyprland_dir/custom-work
hyprlock_config=$hyprland_dir/hyprlock.conf
hyprpaper_config=$hyprland_dir/hyprpaper.conf
#hypridle_config=$hyprland_dir/hypridle.conf
flameshot_config=$config_dir/flameshot/flameshot.ini
fish_config=$config_dir/fish/config.fish
khal_config=$config_dir/khal/config
kitty_config=$config_dir/kitty/kitty.conf
mako_config=$config_dir/mako/config
dunst_config=$config_dir/dunst/dunstrc
fcitx5_profile=$fcitx5_dir/profile

# mkdir
local_path=$local_dir/share
mkdir -p $config_dir
mkdir -p $local_path
#mkdir -p $hyprland_dir_scripts
mkdir -p $hyprland_dir
#mkdir -p $hyprland_custom_work
mkdir -p $fcitx5_local_rime
mkdir -p $fcitx5_conf_dir
mkdir -p $config_dir/fish
mkdir -p $config_dir/flameshot
mkdir -p $config_dir/khal
mkdir -p $config_dir/kitty
mkdir -p $config_dir/mako
mkdir -p $config_dir/dunst
mkdir -p $typora_themes_dir
mkdir -p $vim_dir
mkdir -p $firefox_default_chrome
mkdir -p $yazi_dir

# cp dir
#echo cp $HOME/$hyprland_dir_scripts $hyprland_dir_scripts
cp -r $HOME/$hyprland_dir/. $hyprland_dir
#cp -r $HOME/$hyprland_dir_scripts/. $hyprland_dir_scripts
#cp -r $HOME/$hyprland_custom/. $hyprland_custom_work
#echo cp $HOME/$waybar_dir $waybar_dir
cp -r $HOME/$waybar_dir/. $waybar_dir
#echo cp $HOME/mpv_dir $mpv_dir
cp -r $HOME/$mpv_dir/. $mpv_dir
#echo cp $HOME/$fcitx5_local_rime/*.yaml to $fcitx5_local_rime
cp $HOME/$fcitx5_local_rime/*.yaml $fcitx5_local_rime
#echo cp $HOME/$fcitx5_local_rime_opencc to $fcitx5_local_rime_opencc
cp -r $HOME/$fcitx5_local_rime_opencc/. $fcitx5_local_rime_opencc
cp -r $HOME/$fcitx5_local_rime_build/. $fcitx5_local_rime_build
cp -r $HOME/$fcitx5_local_themes/. $fcitx5_local_themes
cp -r $HOME/$fcitx5_conf_dir/*.conf $fcitx5_conf_dir
cp -r $HOME/$ranger_dir/. $ranger_dir
cp -r $HOME/$rofi_dir/. $rofi_dir
cp -r $HOME/$typora_themes_dir/. $typora_themes_dir
cp -r $HOME/$wlogout_dir/. $wlogout_dir
cp -r $HOME/$wofi_dir/. $wofi_dir
cp -r $HOME/$vim_dir/. $vim_dir
cp -r $HOME/$yazi_dir/. $yazi_dir
#rsync -av --exclude '*/.git/' --exclude='*/.github/' $HOME/$vim_dir/. $vim_dir
cp -r $HOME/$firefox_default_chrome/. $firefox_default_chrome

# clear not need
rm -rf $hyprland_dir/card*
rm -rf $hyprland_dir_scripts/poem/__pycache__/
rm $hyprland_dir_scripts/dbus-monitor/*.log
rm $hyprland_dir_scripts/dbus-monitor/nohup.out
rm -rf $waybar_dir/scripts/poem/__pycache__/
rm -rf $ranger_dir/plugins/__pycache__/
rm -rf $ranger_dir/plugins/ranger_devicons/.git/
rm -rf $ranger_dir/plugins/ranger_devicons/.github/
rm -rf $ranger_dir/plugins/ranger_devicons/__pycache__/
rm -rf $typora_themes_dir/typora-spring-theme/.git
rm -rf $typora_themes_dir/Typro-theme-YuanShan/.git
rm -rf $vim_dir/bundle/tagbar/.git
rm -rf $vim_dir/bundle/tagbar/.github
rm -rf $vim_dir/bundle/vim-auto-save/.git
rm -rf $vim_dir/pack/tpope/start/surround/.git
rm -rf $vim_dir/pack/tpope/start/surround/.github
rm -rf $vim_dir/plugged/coc.nvim/.git
rm -rf $vim_dir/plugged/neoformat/.git    
rm -rf $vim_dir/plugged/nerdtree/.git       
rm -rf $vim_dir/plugged/nerdtree/.github
rm -rf $vim_dir/plugged/python-mode/.git
rm -rf $vim_dir/plugged/python-mode/.github
rm -rf $vim_dir/plugged/vim-startify/.git
rm -rf $vim_dir/plugged/far.vim/.git
rm -rf $vim_dir/plugged/nerdcommenter/.git  
rm -rf $vim_dir/plugged/nerdcommenter/.github
rm -rf $vim_dir/plugged/omnisharp-vim/.git  
rm -rf $vim_dir/plugged/omnisharp-vim/.github
rm -rf $vim_dir/plugged/vim-markdown/.git
rm -rf $vim_dir/plugged/vim-markdown/.github
rm -rf $vim_dir/plugged/vim-translator/.git
rm -rf $vim_dir/plugged/vim-translator/.github

# cp file
#cp $HOME/$hyprland_config $hyprland_config_work
cp $HOME/$hyprlock_config $hyprlock_config
cp $HOME/$hyprpaper_config  $hyprpaper_config 
#cp $HOME/$hypridle_config $hypridle_config
cp $HOME/$fish_config $fish_config
cp $HOME/$flameshot_config $flameshot_config
cp $HOME/$khal_config $khal_config
cp $HOME/$kitty_config $kitty_config
cp $HOME/$mako_config $mako_config
cp $HOME/$dunst_config $dunst_config
cp $HOME/$fcitx5_profile $fcitx5_profile

# set executable shell
find . -type f \( -name "*.sh" -o -name "*.fish" \) -exec git add --chmod=+x {} +

if [ -z "$comment" ];then
	echo not set the comment, just syn.
	git status
else
	echo just commit by \"$comment\" after sync.
	git add .
	git status
	git commit -m "$comment"
	git push
fi
