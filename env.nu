# Nushell Environment Config File
#
# version = "0.104.2"

use std/util "path add"

# Homebrew
path add "/opt/homebrew/bin"

# FNM (Node.js)
fnm env --json | from json | load-env
path add ($env.FNM_MULTISHELL_PATH | path join "bin")

# Rust
source $"($nu.home-path)/.cargo/env.nu"

# PIP
path add (python3 -m site --user-base | str trim | path join "bin")

# `.local/bin`
#
# - Aider
path add $"($nu.home-path)/.local/bin"

# Java
$env.JAVA_HOME = '/opt/homebrew/opt/openjdk@17'
path add $"($env.JAVA_HOME)/bin"

$env.PATH = ($env.PATH | uniq )
