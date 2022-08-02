#!/usr/bin/zsh

set -e

. ~/my/dev/shell/my_utils.sh

main() {
	set -e

	local target_dir=~/my/programs/bin

    if [ -f "$target_dir/nvim.appimage" -o -f "$target_dir/nvim" ]; then
        echo "NeoVim already installed at '$target_dir', skipping"
        return
    fi

    if [ ! -d "$target_dir" ]; then
	    mkdir -p "$target_dir"
    fi

	curl -L \
        https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
        -o "$target_dir/nvim.appimage"

	sudo chmod ug+x "$target_dir/nvim.appimage"

	# if appimage causes problems on some Linux distributions, it might need to
	# be extracted - see Neovim GitHub page

	ln -s "$target_dir/nvim.appimage" "$target_dir/nvim"

	echo "remember to add '$target_dir' to path"

    # configuring NeoVim
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
}

rootcheck_rerun
main
clean_utils_aliases

