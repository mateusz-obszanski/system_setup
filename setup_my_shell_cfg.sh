#!/usr/bin/zsh

set -o errexit -o nounset

# Args:
# - --cleanup
install_fonts() {
	local this_dir=$(pwd)

	if [ -d ./nerd-fonts ]; then
		echo "skipping git clone - repository already exists"
	else
		git clone https://github.com/ryanoasis/nerd-fonts.git --depth 1
	fi

	cd ./nerd-fonts
	git pull -p -f --depth=1
	./install.sh FiraCode
	./install.sh FiraMono

	cd "$this_dir"
	echo "remember to set the newly added font in the terminal settings"

	if [ "$1" -eq "--cleanup" ]; then
		echo "cleaning up the repository"
		rm -rf ./nerd-fonts
	fi
}

# Args:
# - this script's directory (dirname $0)
main() {
	local cfg_target_dir=~/my/configs
	local this_dir="$1"
	local cfg_template="$this_dir/configs/.zshrc"
	local shell_cfg="$HOME/.zshrc"

	if [ ! -d "$cfg_target_dir" ]; then
		echo "creating $cfg_target_dir directory"
		mkdir -p "$cfg_target_dir"
	fi

	echo "copying '$this_dir/configs/my_shell_cfg.sh' to '$cfg_target_dir'"

	if [ -f "$cfg_target_dir/.zshrc" ]; then
		echo "configuration file already there, skipping"
	else
		cp "$this_dir/configs/my_shell_cfg.sh" "$cfg_target_dir"
		chmod ug+x "$cfg_target_dir/my_shell_cfg.sh"
	fi

	if [ -f "$cfg_template" ]; then
		echo "copying custom .zshrc to $HOME directory"
		if [ -f "$shell_cfg" ]; then
			echo "WARNING: the old $shell_cfg will be replaced"
			cp -f "$this_dir/zshrc" ~
		fi
	else
		# no existing config template
		echo "WARNING: no custom config, better make one and save as $cfg_template"
		if [ ! -f "$shell_cfg" ]; then
			echo "ERROR: no $shell_cfg file to modify, aborting"
			exit 1
		fi

		echo "Modifying already existing ~/.zshrc file"
		echo "Adding sourcing of custom shell config"
		echo "# My config (AUTOMATICALLY ADDED)\nsource \"$cfg_target_dir/my_shell_cfg.sh\"" \
			>>"$shell_cfg"

		local plugins="extract fzf git pip python rust poetry"

		echo "Injecting plugins ($plugins)"
		sed -iE "s/^plugins=.*/plugins=($plugins)/" "$shell_cfg"
	fi

	# initialize pyenv
	if [ -x $(command -v pyenv) ]; then
		echo "TODO automatically add penv init stderr to .zshrc"
	fi

	local cargo_env="$HOME/.cargo/env"

	if [ -f "$cargo_env" ]; then
		echo ". $cargo_env" >>"$shell_cfg"
	fi

	echo "Installing fonts"
	install_fonts

	echo "sourcing $shell_cfg"
	. "$shell_cfg"
}

main $(dirname $0)
