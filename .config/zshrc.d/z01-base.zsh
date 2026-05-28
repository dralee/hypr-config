# basic config for zsh
# 2026.5.28 by dralee


export EDITOR=vim
autoload -Uz compinit && compinit
autoload -Uz colors && colors

bindkey -e
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt appendhistory
setopt sharehistory
setopt autocd
setopt correct
setopt interactivecomments

# autoload -Uz compinit && compinit

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh


source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

