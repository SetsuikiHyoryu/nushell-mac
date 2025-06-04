# Nushell Environment Config File
#
# version = "0.104.2"

use std/util "path add"
path add "/opt/homebrew/bin"
fnm env --json | from json | load-env
path add ($env.FNM_MULTISHELL_PATH | path join "bin")
$env.PATH = ($env.PATH | uniq )
