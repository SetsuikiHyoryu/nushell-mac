# Nushell Config File
#
# version = "0.104.2"

let pink = "#fa86c4"
let pink_bold = { fg: $pink attr: b }
let pink_reverse = { fg: "#ffffff", bg: $pink }

$env.config.color_config = {
    separator: white
    leading_trailing_space_bg: { attr: n }
    header: $pink_bold
    empty: blue
    bool: light_cyan
    int: white
    filesize: cyan
    duration: white
    datetime: purple
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cell-path: white
    row_index: $pink_bold
    record: white
    list: white
    closure: $pink_bold
    glob:cyan_bold
    block: white
    hints: dark_gray
    search_result: { bg: red fg: white }
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_closure: $pink_bold
    shape_custom: $pink
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: $pink_bold
    shape_external_resolved: light_yellow_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    shape_glob_interpolation: cyan_bold
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_keyword: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_match_pattern: $pink
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: $pink_bold
    shape_string: $pink
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
    shape_vardecl: purple
    shape_raw_string: light_purple
    shape_garbage: {
        fg: white
        bg: red
        attr: b
    }
}

$env.config.menus ++= [
    {
        name: help_menu,
        only_buffer_difference: true # Search is done on the text written after activating the menu
        marker: "? "                 # Indicator that appears with the menu is active
        type: {
            layout: description      # Type of menu
            columns: 4               # Number of columns where the options are displayed
            col_width: 20            # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2           # Padding between columns
            selection_rows: 4        # Number of rows allowed to display found options
            description_rows: 10     # Number of rows allowed to display command description
        }
        style: {
            text: $pink                   # Text style
            selected_text: $pink_reverse  # Text style for selected option
            description_text: yellow      # Text style for description
        }
    },

    {
        name: completion_menu
        only_buffer_difference: false # Search is done on the text written after activating the menu
        marker: "| "                  # Indicator that appears with the menu is active
        type: {
            layout: columnar          # Type of menu
            columns: 4                # Number of columns where the options are displayed
            col_width: 20             # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2            # Padding between columns
        }
        style: {
            text: $pink                   # Text style
            selected_text: $pink_reverse  # Text style for selected option
            description_text: yellow      # Text style for description
        }
    },

    {
        name: history_menu
        only_buffer_difference: true # Search is done on the text written after activating the menu
        marker: "? "                 # Indicator that appears with the menu is active
        type: {
            layout: list             # Type of menu
            page_size: 10            # Number of entries that will presented when activating the menu
        }
        style: {
            text: $pink                   # Text style
            selected_text: $pink_reverse  # Text style for selected option
            description_text: yellow      # Text style for description
        }
    }
]

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.config.edit_mode = "vi"
$env.config.table.mode = "light"

# PROMPT_INDICATOR*
# -----------------
# The prompt indicators are environmental variables that represent
# the state of the prompt. The specified character(s) will appear
# immediately following the PROMPT_COMMAND

# When in Emacs mode (default):
$env.PROMPT_INDICATOR = "> "

# When in normal vi mode:
$env.PROMPT_INDICATOR_VI_NORMAL = " "
# When in vi insert-mode:
$env.PROMPT_INDICATOR_VI_INSERT = " "

# When a commandline extends across multiple lines:
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# --- Third Party Custom ---

# Use Theme (Third Party Prompt)
let posh_theme = "~/.poshthemes/"
# Change the theme names to: zash/space/robbyrussel/powerline/powerlevel10k_lean/
# material/half-life/lambda Or double lines theme: amro/pure/spaceship, etc.
# For more [Themes demo](https://ohmyposh.dev/docs/themes)
$env.PROMPT_COMMAND = { || oh-my-posh prompt print primary --config $'($posh_theme)/tokyo_mine.omp.json' }
# Optional
$env.PROMPT_INDICATOR = $"(ansi y) (ansi reset)"

$env.PROMPT_COMMAND_RIGHT = {||}

# [[Yazi]]
# Use `yaya` instead of yazi to start, and press q to quit, you'll see the CWD changed.  
# Sometimes, you don't want to change, press Q to quit.
def --env yaya [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -fp $tmp
}
