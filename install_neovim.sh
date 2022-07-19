source ~/my/dev/shell/my_utils.sh

rootcheck_rerun

main() {
	local target_path=~/my/programs/bin
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	sudo chmod ug+x ./nvim.appimage
	mkdir -p "$target_path"
	mv ./nvim.appimage "$target_path"
}

main

