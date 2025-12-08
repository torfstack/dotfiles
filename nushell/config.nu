# --- CONFIG ---
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

# --- ALIAS ---
alias vim = nvim
alias k = k9s
alias t = tmux

alias i3c = nvim $"($env.HOME)/.config/i3/config"
alias pico = nvim $"($env.HOME)/.config/i3/picom.conf"
alias downsync = rclone sync googledrive: $"($env.HOME)/drive"
alias upsync = rclone sync $"($env.HOME)/drive" googledrive:

# --- COMPLETIONS --- source $"($nu.cache-dir)/carapace.nu"

# --- COLORS ---
$env.config.color_config = {
    shape_string: { attr: "n" }
    shape_filepath: { attr: "n" }
    shape_directory: { attr: "n" }
    shape_externalarg: { attr: "n" }
    shape_globpattern: { attr: "n" }
    shape_external: "green"
    shape_pipe: "white"
}

# --- STARSHIP ---
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# --- SDKMAN wrapper ---
def sdk [...args] {
    ^bash -c $"source ~/.sdkman/bin/sdkman-init.sh && sdk ($args | str join ' ')"
}

