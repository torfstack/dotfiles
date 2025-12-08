# env.nu
#
# Installed by:
# version = "0.108.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

# --- PATH ---
$env.PATH = ($env.PATH | append $"($env.HOME)/bin")
$env.PATH = ($env.PATH | append $"($env.HOME)/go/bin")
$env.PATH = ($env.PATH | append $"($env.HOME)/.cargo/bin")

# --- SDKMAN ---
$env.SDKMAN_DIR = $"($env.HOME)/.sdkman"

# --- COMPLETIONS ---
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

# --- SDKMAN (java) ---
$env.SDKMAN_DIR = $"($env.HOME)/.sdkman"
let java_current = "/home/david/.sdkman/candidates/java/current"

if ($java_current | path exists) {
    $env.JAVA_HOME = $java_current
    $env.PATH = ($env.PATH | prepend $"($java_current)/bin")
}
