if [ ! -d ~/.config/nvim ]; then
	mkdir ~/.config/nvim
fi

if [ ! -f ~/.config/nvim/init.vim ]; then
	cp ./configs/neovim/init.vim ~/.config/nvim/
else
	echo "Found existing init.vim at ~/.config/nvim, skipping"
fi

