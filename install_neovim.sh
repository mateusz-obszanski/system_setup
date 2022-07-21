source ~/my/dev/shell/my_utils.sh

rootcheck_rerun

main() {
	local target_dir=~/my/programs/bin
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	sudo chmod ug+x ./nvim.appimage
	mkdir -p "$target_dir"
	mv ./nvim.appimage "$target_dir"
	# if appimage causes problems, it might need to be extracted - see
	# Neovim GitHub page
	ln -s "$target_dir/nvim.appimage" "$target_dir/nvim"
	echo "remember to add '$target_dir' to path"
}

main

