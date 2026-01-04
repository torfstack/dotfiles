# --- PATH & ENV ---
use std ["path add"]
path add $"($env.HOME)/bin" $"($env.HOME)/go/bin" $"($env.HOME)/.cargo/bin"

$env.SDKMAN_DIR = $"($env.HOME)/.sdkman"
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

# SDKMAN (Java)
let java_current = $"($env.HOME)/.sdkman/candidates/java/current"
if ($java_current | path exists) {
    $env.JAVA_HOME = $java_current
    path add $"($java_current)/bin"
}

# --- AUTO-GENERATE INTEGRATIONS ---
# This uses Index 4 from your $nu.vendor-autoload-dirs
let autoload_dir = ($nu.data-dir | path join "vendor/autoload")
if not ($autoload_dir | path exists) { mkdir $autoload_dir }

let starship_path = ($autoload_dir | path join "starship.nu")
let carapace_path = ($autoload_dir | path join "carapace.nu")
let mise_path     = ($autoload_dir | path join "mise.nu")

if not ($starship_path | path exists) { ^starship init nu | save -f $starship_path }
if not ($carapace_path | path exists) { ^carapace _carapace nushell | save -f $carapace_path }
if not ($mise_path     | path exists) { ^mise activate nu | save -f $mise_path }
