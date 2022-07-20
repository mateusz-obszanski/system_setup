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

main() {
	// Python
	local python_dir="/usr/bin"
	local python_major=3
	local python_minor=10
	local python_micro=5
	local python_version="${python_major}.${python_minor}.${python_micro}"
	local python_cmd="${python_dir}/python$python_version"

	alias py="$python_cmd"
	alias ipy="$python_cmd -m IPython"
	alias pip="$python_cmd -m pip"
	
	_cfg_tilix_terminal
	_source_custom_utils
	
	export path="$path:~/my/programs/bin"
}

main

