main() {
	local cfg_target_dir=~/my/configs
	local cfg_template=./configs/.zshrc

	if [ ! -d "$cfg_target_dir" ]; then
		echo "creating $cfg_target_dir directory"
		mkdir -p "$cfg_target_dir"
	fi

	echo "copying './configs/my_shell_cfg.sh' to $cfg_target_dir"
	
	if [ -f "$cfg_target_dir/.zshrc" ]; then
		echo "configuration file already there, skipping"
	else
		cp ./configs/my_shell_cfg.sh "$cfg_target_dir"
		chmod ug+x "$cfg_target_dir/my_shell_cfg.sh"
	fi

	if [ -f "$cfg_template" ]; then
		echo "copying custom .zshrc to $HOME directory"
		if [ -f ~/.zshrc ]; then
			echo "WARNING: the old ~/.zshrc will be replaced"
			cp -f ./zshrc ~
		fi
	else
		echo "WARNING: no custom config, better make one and save as $cfg_template"
		if [ ! -f ~/.zshrc ]; then
			echo "ERROR: no ~/.zshrc file to modify, aborting"
			exit 1
		fi
		
		echo "Modifying already existing ~/.zshrc file"
		echo "Adding sourcing of custom shell config"
		echo "# My config (AUTOMATICALLY ADDED)\nsource \"$cfg_target_dir/my_shell_cfg.sh\"" \
			>> ~/.zshrc
		local plugins="extract fzf git pip python rust"
		echo "Injecting plugins ($plugins)"
		sed -iE "s/plugins=.*/plugins=($plugins)/"
	fi
	
	echo "sourcing ~/.zshrc"
	. ~/.zshrc
}

main

