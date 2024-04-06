## for homebrew
# Homebrewの設定。fishではevalの代わりにsourceを使用します。
set -q HOMEBREW_PREFIX; or set -gx HOMEBREW_PREFIX (/opt/homebrew/bin/brew --prefix)
set -gx PATH $HOMEBREW_PREFIX/bin $PATH

## for nodenv
# nodenvの初期化。
status is-interactive; and source (nodenv init -|psub)

set -gx PATH $HOME/.nodenv/bin $PATH

# pyenv
set -gx PYENV_ROOT "$HOME/.pyenv/shims"
set -gx PATH $PYENV_ROOT $PATH
set -gx PIPENV_PYTHON "$PYENV_ROOT/python"

## for rbenv
# rbenvの初期化。fish用の設定に変更する必要があります。
# status is-interactive; and source (rbenv init -|psub)

set -gx PATH $HOME/.rbenv/shims $PATH

# alias
alias brew='sudo -Hu homebrew brew'

# fzf
set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_LEGACY_KEYBINDINGS 0
