#!/usr/bin/zsh

set -e

. ~/my/dev/shell/my_utils.sh

main() {
	set -e

	local target_dir=~/my/programs/bin

	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	sudo chmod ug+x ./nvim.appimage
	mkdir -p "$target_dir"
	mv ./nvim.appimage "$target_dir"
	# if appimage causes problems on some Linux distributions, it might need to
	# be extracted - see Neovim GitHub page
	ln -s "$target_dir/nvim.appimage" "$target_dir/nvim"
	echo "remember to add '$target_dir' to path"
}

rootcheck_rerun
main
clean_utils_aliases
