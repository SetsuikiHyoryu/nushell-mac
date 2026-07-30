# Nushell Environment Config File
#
# version = "0.104.2"

# 注意，`path add` 直接调用是在最前方插入，而最前方的 path 优先级最高。  
# 如果需要在最后方插入，应该用 `path add --append`。  
# 考虑到加载 Nusehll 之前已经有 path 了，当前就采用倒序书写 `path add` 的方式。  
# 可以用 `print $env.PATH` 打印 path 顺序。
use std/util "path add"

# /usr/local/bin/
#
# GUI 安装的程序通常在这儿。  
# 因为其他位置存在同名的程序，我需要这里的优先级最低，因此放在 PATH 的最后。
path add "/usr/local/bin/"

# `.local/bin`
#
# - Aider
path add $"($nu.home-dir)/.local/bin"

# Homebrew
path add "/opt/homebrew/bin"

# Java
$env.JAVA_HOME_17 = '/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home'
$env.JAVA_HOME_21 = '/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home'
$env.JAVA_HOME_24 = '/Library/Java/JavaVirtualMachines/jdk-24.jdk/Contents/Home'
$env.JAVA_HOME_FOR_JDTLS = $env.JAVA_HOME_21
$env.JAVA_HOME = $env.JAVA_HOME_21
path add $"($env.JAVA_HOME)/bin"

# PIP
path add (python3 -m site --user-base | str trim | path join "bin")

# FNM (Node.js)
fnm env --json | from json | load-env
path add ($env.FNM_MULTISHELL_PATH | path join "bin")

# pnpm
# Use pnpm v11+ and use `pnpm setup` to create this file.
# See: <https://pnpm.io/zh/cli/setup>
source $"($nu.home-dir)/.config/nushell/env.nu"

# Rust
source $"($nu.home-dir)/.cargo/env.nu"

$env.PATH = ($env.PATH | uniq )

# Others not PATH
$env.EDITOR = 'nvim'
