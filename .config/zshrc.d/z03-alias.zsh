# alias for zsh
# 2026.5.28 by dralee

alias ls='eza'
alias ll='eza -lah'
#alias cat='bat'

alias y='yazi'

alias gs='git status'
alias ga='git add'
alias gc='git checkout'
alias gm='git commit'
alias gtl='git stash list'
alias gtp='git stash pop'
alias gta='git stash apply'
alias gt='git stash'
alias gpl='git pull'
alias gp='git push'
alias gf='git fetch'
alias gl='git log'
alias auto-ug-mihomo='$HOME/Application/shells/auto-mihomo-upgrade.sh'
alias audio-switch='$HOME/.config/shells/audio-switch.sh'
alias auto-jetbrains-upgrade='$HOME/Application/shells/auto-jetbrains-upgrade.sh'
alias auto-mihomo-upgrade='$HOME/Application/shells/auto-mihomo-upgrade.sh'
alias auto-mihomo-ver='$HOME/Application/shells/auto-mihomo-latest-ver.sh'
alias auto-upgrade-qq='$HOME/Application/shells/auto-upgrade-qq.sh'
alias auto-upgrade-redis-insight='$HOME/Application/shells/auto-upgrade-redis-insight.sh'
alias backup-mobile='$HOME/Application/shells/backup-mobile.sh'
alias cp-mobile-file='$HOME/Application/shells/cp-mobile-file.sh'
alias loop-call='$HOME/Application/shells/request/loop-call.sh'
alias request-for='$HOME/Application/shells/request/request-for-url.sh'
alias wg-down='sudo systemctl stop wg-quick@wg0'
alias wg-up='sudo systemctl start wg-quick@wg0'

# ip for public
alias ipx='curl -L -s http://ipecho.net/plain, curl -L -s http://whatismijnip.nl'
# check the response of the site, $1, eg: csite https://www.google.com
alias csite="curl -s -w \
     '\nLookup time:\t%{time_namelookup}\nConnect time:\t%{time_connect}\nAppCon time:\t%{time_appconnect}\nRedirect time:\t%{time_redirect}\nPreXfer time:\t%{time_pretransfer}\nStartXfer time:\t%{time_starttransfer}\n\nTotal time:\t%{time_total}\n' \
     -o /dev/null"

# work fish alias
if [[ "$HYPR_RUN_PC_ENV" = "work" ]];then
	alias abk='$HOME/Application/shells/auto-back.sh'
	alias auth-res-rar='$HOME/Application/shells/net/auth-res-rar.sh'
	alias auto-bk='$HOME/Application/shells/auto-bk.sh'
	alias backup='$HOME/f/workspace/bk/backup.sh $HOME/f/workspace/bk'
	alias clear-bk='$HOME/f/workspace/bk/clear.sh $HOME/f/workspace/bk'
	alias convert-arg='$HOME/Application/shells/request/convert-curl-to-request-arg.sh'
	alias dr-rm-exit='sudo docker rm -f \\\\$(sudo docker ps -a | awk "/Exit/ {print \\\\$1}")'
	alias git-branch-clean='$HOME/Application/shells/git-branch-clean.sh'
	alias kvm-start='$HOME/Application/shells/kvm/start.sh'
	alias mb='$HOME/Application/shells/merge-fat.sh'
	alias mydev='mycli -h 192.168.0.220 -P 4000 -u z9yun_dev_dba -p JYq6L6aohycIlVDLVGZ'
	alias myfat='mycli -h 192.168.0.220 -P 4000 -u z9yun_fat_all_readonly -p 3jd8aazr,hGZ1UCQFI8'
	#alias navicat-desktop='cd $HOME/f/.wine/drive_c/users/dralee/Desktop'
	alias nginx='sudo /usr/local/nginx/nginx'
	alias pp='$HOME/Application/shells/pull-project.sh'
	alias rider-upgrade='$HOME/Application/shells/upgrade-rider-jbr.sh $HOME/Application/shells/'
	#alias run-z9='$HOME/f/workspace/temp/back/run-z9.sh -o $HOME/f/workspace/temp/back/'
fi

alias del='mv -t ~/.local/share/Trash/files/ --backup'
alias request-for='$HOME/Application/shells/request/request-for-url.sh'
alias free-m='sudo ~/Application/shells/free-m.sh'
alias towechat='$HOME/.local/bin/towechat.sh'
alias upgrade-idea='$HOME/Application/shells/upgrade-jbr.sh idea $HOME/Application/shells'
alias upgrade-qq='$HOME/Application/shells/upgrade-qq.sh'
alias upgrade-redis-insight='$HOME/Application/shells/upgrade-redis-insight.sh'
alias upgrade-rider='$HOME/Application/shells/jbr/upgrade-jbr.sh rider $HOME/Application/shells/jbr'
alias vscode='code --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime'

alias cg='$HOME/Application/shells/bash/cd-git.sh'
alias cpull='$HOME/Application/shells/bash/checkout-pull-git.sh'
alias tod='$HOME/Application/shells/bash/tod.sh'

