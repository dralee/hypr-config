# config for completions
# 2026.5.28 by dralee

# completion system
fpath+=/usr/share/zsh/site-functions

autoload -Uz compinit
compinit

# completion menu
zstyle ':completion:*' menu select

# case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# colored completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh/

# process completion
zstyle ':completion:*:processes' command 'ps -u $USER -o pid,cmd'