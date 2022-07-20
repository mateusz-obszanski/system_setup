fexplorer() {
	if [ -z "$@" ]; then
		xdg-open .
	else
		xdg-open $@
	fi
}

as_bool() {
	local _true=0
	local _false=1
	local boolean_result=$_true;
	`[ ${@} ]` || boolean_result=$_false;
	echo $boolean_result;
}

rootcheck() {
	[ $(id -u) -eq 0 ] || false;
}

# Tries to re-run the script in which has been called as the root user
# Usage:
# 	_rootcheck_rerun "${@}"
_rootcheck_rerun() {
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
	# if not a root
	if rootcheck; then
		echo "ERROR: You must run this script as the root user"
		exit 1
	fi
}

