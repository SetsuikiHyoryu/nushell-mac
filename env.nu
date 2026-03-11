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
$env.JAVA_HOME_17 = '/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home'
$env.JAVA_HOME_21 = '/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home'
$env.JAVA_HOME_24 = '/Library/Java/JavaVirtualMachines/jdk-24.jdk/Contents/Home'
$env.JAVA_HOME_FOR_JDTLS = $env.JAVA_HOME_21
$env.JAVA_HOME = $env.JAVA_HOME_21
path add $"($env.JAVA_HOME)/bin"

# /usr/local/bin/
#
# GUI 安装的程序通常在这儿。  
# 因为其他位置存在同名的程序，我需要这里的优先级最低，因此放在 PATH 的最后。
path add "/usr/local/bin/"

$env.PATH = ($env.PATH | uniq )
