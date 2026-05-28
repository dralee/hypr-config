# basic config for zsh
# 2026.5.28 by dralee


export EDITOR=vim
autoload -Uz compinit && compinit
autoload -Uz colors && colors

bindkey -e
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

bindkey "^[[3~" delete-char

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line


HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt appendhistory
setopt sharehistory
setopt autocd
setopt correct
setopt interactivecomments

# autoload -Uz compinit && compinit




