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


# vi mode
function fish_user_key_bindings
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
    if test "$__fish_active_key_bindings" = fish_vi_key_bindings
        bind -M insert -m default jk force-repaint
    end
end

function ide
    tmux split-window -v -l 30%; and tmux split-window -h -l 66%; and tmux split-window -h -l 50%
end

funcsave ide


switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config.osx.fish
    case Linux
        source (dirname (status --current-filename))/config.linux.fish
    case '*'
        source (dirname (status --current-filename))/config.windows.fish
end
