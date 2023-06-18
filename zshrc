# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme romkatv/powerlevel10k

antigen apply

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias scr=screenfetch
alias hack="vim tryhackme.notes"

alias flut="cd ~/Dev/flutter"

export PATH=$PATH:/home/david/bin
export PATH=$PATH:/home/david/go

alias vim=nvim
alias vimc="nvim /home/david/.dotfiles/nvim/init.lua"
alias plugc="nvim /home/david/.dotfiles/nvim/lua/plugins.lua"
alias termc="nvim ~/.config/terminator/config"
alias i3c="nvim ~/.config/i3/config"
alias prof="nvim ~/.profile" 
alias pico="nvim ~/.config/i3/picom.conf"
alias godot="godot3-mono-bin" 

source /usr/share/zsh/share/antigen.zsh
