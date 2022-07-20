main() {
	local cfg_target_dir=~/my/configs

	if [ ! -d "$cfg_target_dir" ]; then
		echo "creating $cfg_target_dir directory"
		mkdir -p "$cfg_target_dir"
	fi

	echo "copying './my_shell_cfg.sh' to $cfg_target_dir"
	
	if [ -f "$cfg_target_dir" ]; then
		echo "configuration file already there, skipping"
	else
		cp ./my_shell_cfg.sh "$cfg_target_dir"
	fi

	if [ -f ./zshrc ]; then
		echo "copying custom .zshrc to $HOME directory"
		if [ -f ~/.zshrc ]; then
			echo "WARNING: the old ~/.zshrc will be replaced"
			cp -f ./zshrc ~
		fi
	else
		if [ ! -f ~/.zshrc ]; then
			echo "ERROR: no ~/.zshrc file to modify, aborting"
			exit 1
		fi
		
		echo "Modifying already existing ~/.zshrc file"
		echo "# My config (AUTOMATICALLY ADDED)\nsource \"$cfg_target_dir\"" \
			>> ~/.zshrc
	fi
{

main

