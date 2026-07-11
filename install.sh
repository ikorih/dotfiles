# use colors on terminal
if which tput >/dev/null 2>&1; then
  ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi

usage() {
  echo $YELLOW
  cat <<\EOF
Commands:
  setup-brew (install Homebrew and packages from Brewfile)
  font-nerd (install Nerd Font)
  setup-links (create symbolic links for Apple Silicon or Ubuntu)
  setup-git (configure global Git settings)
  quit
EOF
  echo $NORMAL
}

setup_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "${BLUE}Installing Homebrew...${NORMAL}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ "$(uname)" == "Darwin" && -x /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  fi
  echo "${BLUE}Installing packages from Brewfile...${NORMAL}"
  echo "${YELLOW}Note: mas apps require you to be signed in to the App Store.${NORMAL}"
  brew bundle install --file ~/dotfiles/Brewfile
  echo "${GREEN}Homebrew setup completed!${NORMAL}"
}

nerd_fonts() {
  git clone --branch=master --depth=1 https://github.com/ryanoasis/nerd-fonts.git
  cd nerd-fonts
  ./install.sh $1
  cd ..
  rm -rf nerd-fonts
}

setup_links() {
  ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
  ln -s ~/dotfiles/zsh/zshrc ~/.zshrc

  # Determine the OS type and create the appropriate .zshrc_local link
  if [[ "$(uname)" == "Darwin" ]]; then
    ln -s ~/dotfiles/zsh/zshrc_local_mac_silicon ~/.zshrc_local
  elif [[ "$(uname)" == "Linux" ]]; then
    ln -s ~/dotfiles/zsh/zshrc_local_ubuntu ~/.zshrc_local
  fi

  # Ensure .config directory exists
  mkdir -p ~/.config
  ln -s ~/dotfiles/nvim ~/.config/nvim
  ln -s ~/dotfiles/lazygit ~/.config/lazygit
  ln -s ~/dotfiles/changelog.config.js ~/changelog.config.js
  echo "${GREEN}Symbolic links created successfully!${NORMAL}"

  # Check for secret file and copy from template if it doesn't exist
  if [ ! -f "$HOME/.zshrc_secrets" ]; then
    cp ~/dotfiles/zsh/zshrc_secrets.example "$HOME/.zshrc_secrets"
    echo "${YELLOW}Copied .zshrc_secrets.example to ~/.zshrc_secrets. Please edit ~/.zshrc_secrets and add your API keys.${NORMAL}"
  fi
}

setup_git() {
  git config --global user.name "Hiroki Fujikami"
  git config --global user.email "ikorih@protonmail.com"
  git config --global core.editor 'vim -c "set fenc=utf-8"'
  echo "${GREEN}Git configuration set successfully!${NORMAL}"
}

# main
# --------------
main() {
  usage
  echo -n "${BOLD}command: $NORMAL"
  read command
  case $command in
  setup-brew)
    setup_brew
    main
    ;;
  font-nerd)
    nerd_fonts Meslo
    main
    ;;
  setup-links)
    setup_links
    main
    ;;
  setup-git)
    setup_git
    main
    ;;
  quit)
    echo "bye!"
    exit 0
    ;;
  *)
    echo "${RED}command not found.$NORMAL"
    main
    ;;
  esac
}

main

exit 0
