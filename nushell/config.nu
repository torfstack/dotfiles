# --- SETTINGS ---
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false
$env.config.highlight_resolved_externals = true

# --- COLORS ---
$env.config.color_config = {
    shape_string: { attr: "n" }
    shape_filepath: { attr: "n" }
    shape_directory: { attr: "n" }
    shape_externalarg: { attr: "n" }
    shape_globpattern: { attr: "n" }
    shape_pipe: "white"
    shape_external: "red"
    shape_external_resolved: "green" 
}

# --- ALIASES ---
alias vim = nvim
alias k = k9s
alias t = tmux
alias i3c = nvim $"($env.HOME)/.config/i3/config"
alias pico = nvim $"($env.HOME)/.config/i3/picom.conf"
alias downsync = rclone sync googledrive: $"($env.HOME)/drive"
alias upsync = rclone sync $"($env.HOME)/drive" googledrive:

# --- REGENERATE INTEGRATIONS
def --env "nu-reload-integrations" [] {
    let autoload_dir = ($nu.data-dir | path join "vendor/autoload")
    rm -rf $autoload_dir
    mkdir $autoload_dir
    print "Integrations cleared. Restart Nushell to regenerate."
}
