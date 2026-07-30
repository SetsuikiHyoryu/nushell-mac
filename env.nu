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

# Python
#
# 1. 为什么不用其他方式动态获取路径。
#
#    `python3 -m site --user-base` 只能拿到 `--user` 方式安装的目录，  
#    但这里的包是全局安装的，用它拿不到实际所在位置。
#
# 2. 为什么放在 `/usr/local/bin` 之后、Homebrew 之前。
#
#    只是为了让这一行的 `python3` 调用解析到 python.org 那份，  
#    从而算对它的 scripts 目录，其中含有 pip 以及它所装的包。
#
# 3. 当前的风险。
#
#    最终 PATH 里 Homebrew 优先级更高，裸调 python3、pip3 会进 Homebrew 环境，  
#    装包会被 PEP 668 拒绝。  
#    管理依赖用裸 `pip`（不带 3）最安全：  
#    Homebrew 和 `/usr/local/bin` 都没有裸 `pip`，只有 python.org 那份提供；  
#    `pip3`、`python3 -m pip` 两边都有，会被 Homebrew 抢走。
#
# 4. 今后使用需要注意。
#
#    如果要从环境变量（PATH）里调用 python，注意看清楚实际调的是哪一个，  
#    机器上有多个 python 时，小心不要调到 Homebrew 里的那份。
path add (python3 -c "import sysconfig; print(sysconfig.get_path('scripts'))")

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
