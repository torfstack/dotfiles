autoload -Uz compinit
compinit

source $HOME/.antidote/antidote.zsh
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
alias i3c="nvim $HOME/.config/i3/config"
alias pico="nvim $HOME/.config/i3/picom.conf"
alias downsync="rclone sync googledrive: $HOME/drive"
alias upsync="rclone sync $HOME/drive googledrive:"

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin

# task runner
eval "$(task --completion zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
