source /usr/share/zsh/share/antigen.zsh

# weird bug with antigen and oh-my-zsh, need to force the async-prompt to load before sourcing oh-my-zsh
zstyle ':omz:alpha:lib:git' async-prompt force

antigen use oh-my-zsh

antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

antigen bundle mafredri/zsh-async@main
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme robbyrussell

antigen apply

# aliases
alias vim=nvim
alias i3c="nvim ~/.config/i3/config"
alias prof="nvim ~/.profile" 
alias pico="nvim ~/.config/i3/picom.conf"
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias k="TERM=xterm-256color k9s"
alias t="tmux"
alias s="TERM=xterm-256color ssh -p 103 david@torfstack.com"
alias f="fastfetch"
alias v="vim ."
alias gu="go-mod-upgrade"

export CR_PAT="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"

# bun completions
[ -s "/home/david/.bun/_bun" ] && source "/home/david/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# rsync
alias downsync="rclone sync googledrive: /home/david/drive"
alias upsync="rclone sync /home/david/drive googledrive:"

# pipx installed packages
export PATH="$PATH:/home/david/.local/bin"

export PATH=$PATH:/home/david/bin
export PATH=$PATH:/home/david/go/bin
export PATH=$PATH:/home/david/.cargo/bin

# task runner
eval "$(task --completion zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
