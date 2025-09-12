autoload -Uz compinit
compinit

source ~/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

# aliases
alias vim=nvim
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias k="TERM=xterm-256color k9s"
alias t="tmux"
alias s="TERM=xterm-256color ssh -p 103 david@torfstack.com"
alias f="fastfetch"
alias v="vim ."
alias gu="go-mod-upgrade"

# linux only
alias i3c="nvim ~/.config/i3/config"
alias pico="nvim ~/.config/i3/picom.conf"
