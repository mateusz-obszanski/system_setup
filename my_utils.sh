fexplorer() {
	set -e

	if [ -z "$@" ]; then
		xdg-open .
	else
		xdg-open $@
	fi
}

alias fex=fexplorer

as_bool() {
	set -e

	local _true=0
	local _false=1
	local boolean_result=$_true

	$([ ${@} ]) || boolean_result=$_false
	echo $boolean_result
}

rootcheck() {
	[ $(id -u) -eq 0 ] || false
}

# Tries to re-run the script in which has been called as the root user
# Usage:
# 	_rootcheck_rerun "${@}"
_rootcheck_rerun() {
	set -e

	# if not a root
	if rootcheck; then
		# re-enter the program, ask for the password (-k)
		exec sudo -k "${0}" "${@}"
		exit $?
	fi
}

alias rootcheck_rerun='_rootcheck_rerun $@'

# Exits if not run as the root user
# Usage:
# 	rootcheck
rootcheck_exit() {
	set -e

	# if not a root
	if rootcheck; then
		echo "ERROR: You must run this script as the root user"
		exit 1
	fi
}

# Install from OS distribution repository
alias dinstall="sudo apt install -y"
alias dupdate="sudo apt update"
alias dupinstall="dupdate && dinstall"
alias dupgrade="sudo apt upgrade -y"

alias clean_utils_aliases="unalias dinstall dupdate dupinstall dupgrade clean_utils_aliases"
