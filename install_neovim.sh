source ~/my/dev/shell/my_utils.sh

rootcheck_rerun

main() {
	local target_dir=~/my/programs/bin
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	sudo chmod ug+x ./nvim.appimage
	mkdir -p "$target_dir"
	mv ./nvim.appimage "$target_dir"
	echo "remember to add '$target_dir' to path"
}

main

