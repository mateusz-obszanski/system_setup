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
	# Python
	local python_major=3
	local python_minor=10
	local python_micro=5
	local python_version="${python_major}.${python_minor}"
    local python_version_full="$python_version.$python_micro"
	local python_dir="~/my/programs/Python-$python_version_full"
	local python_cmd="${python_dir}/bin/python$python_version"
	local ipython_cmd="$python_cmd -m IPython"

	alias python="$python_cmd"
	alias py="$python_cmd"
	alias ipython="$ipython_cmd"
	alias ipy="$ipython_cmd"
	alias pip="$python_cmd -m pip"

	alias vim="nvim"

	alias shrug="echo '¯\_(ツ)_/¯'"

	# Tilix shouted about that but sourced file does not exist
	# _cfg_tilix_terminal
	_source_custom_utils
	
	export PATH="$PATH:~/my/programs/bin"
}

main

