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
alias downsync="rclone sync googledrive: /home/david/drive"
alias upsync="rclone sync /home/david/drive googledrive:"

export PATH=$PATH:/home/david/bin
export PATH=$PATH:/home/david/go/bin
export PATH=$PATH:/home/david/.cargo/bin

# task runner
eval "$(task --completion zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
