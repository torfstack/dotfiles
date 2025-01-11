source /usr/share/zsh/share/antigen.zsh

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

alias scr=screenfetch
alias hack="vim tryhackme.notes"

alias flut="cd ~/Dev/flutter"

export PATH=$PATH:/home/david/bin
export PATH=$PATH:/home/david/go/bin
export PATH=$PATH:/home/david/.cargo/bin

alias vim=nvim
alias vimc="nvim /home/david/.dotfiles/nvim/init.lua"
alias plugc="nvim /home/david/.dotfiles/nvim/lua/plugins.lua"
alias termc="nvim ~/.config/terminator/config"
alias i3c="nvim ~/.config/i3/config"
alias prof="nvim ~/.profile" 
alias pico="nvim ~/.config/i3/picom.conf"
alias godot="godot3-mono-bin" 
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias k="TERM=xterm-256color k9s"
alias t="tmux"
alias s="TERM=xterm-256color ssh -p 103 david@torfstack.com"
alias f="fastfetch"

export EDITOR=nvim
export CR_PAT="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"

# bun completions
[ -s "/home/david/.bun/_bun" ] && source "/home/david/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# go
DISABLE_UNTRACKED_FILES_DIRTY="true"

# rsync
alias downsync="rclone sync googledrive: /home/david/drive"
alias upsync="rclone sync /home/david/drive googledrive:"

# pipx installed packages
export PATH="$PATH:/home/david/.local/bin"

