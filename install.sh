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
  font-nerd (install Nerd Font)
  setup-links (create symbolic links for Apple Silicon)
  setup-git (configure global Git settings)
  quit
EOF
	echo $NORMAL
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
	ln -s ~/dotfiles/zsh/zshrc_local_mac_silicon ~/.zshrc_local
	# Ensure .config directory exists
	mkdir -p ~/.config
	ln -s ~/dotfiles/nvim ~/.config/nvim
	ln -s ~/dotfiles/fish ~/.config/fish
	ln -s ~/dotfiles/lazygit ~/.config/lazygit
	ln -s ~/dotfiles/changelog.config.js ~/changelog.config.js
	echo "${GREEN}Symbolic links created successfully!${NORMAL}"
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
