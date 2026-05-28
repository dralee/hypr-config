# plugins for zsh
# 2026.5.28 by dralee

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# accept full
bindkey '^[[C' autosuggest-accept

# accept word (Fish-like)
bindkey '^[f' autosuggest-accept-word

# Fish-like suggestion behavior
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
    forward-char
    end-of-line
)

ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(
    backward-char
    backward-delete-char
)