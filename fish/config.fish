set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user no
set -g theme_hide_hostname no
set -g theme_hostname always
set -g theme_display_git_default_branch yes


set -gx EDITOR nvim

# alias
alias vim='nvim'


switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config.osx.fish
    case Linux
        source (dirname (status --current-filename))/config.linux.fish
    case '*'
        source (dirname (status --current-filename))/config.windows.fish
end
