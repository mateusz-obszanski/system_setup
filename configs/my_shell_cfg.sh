_cfg_tilix_terminal() {
	if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
		source /etc/profile.d/vte.sh
	fi
}

_source_custom_utils() {
	local utils_path=~/my/dev/shell/my_utils.sh
	if [ -f "$utils_path" ]; then
		source "$utils_path"
	else
		echo "WARNING: could not load custom utility functions, because '$utils_path' does not exist"
	fi
}

_extend_path() {
	export PATH="$PATH:$1"
}

main() {
	set -o errexit -o nounset

	# Python
	local my_programs_dir="$HOME/my/programs/bin"

	alias vim="nvim"
	alias tree1="tree -L 1"

	alias shrug="echo '¯\_(ツ)_/¯'"

	# For color output to work with less
	alias ls="ls --color=always"
	alias less="less -R"

	# Tilix shouted about that but sourced file does not exist
	# _cfg_tilix_terminal
	_source_custom_utils

	_extend_path "$my_programs_dir"
	# add pyenv
	[ -d "$pyenv_dir" ] && _extend_path "$pyenv_dir"

	set +o errexit +o nounset
}

main
