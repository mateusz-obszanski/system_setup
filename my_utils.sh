TRUE=0
FALSE=1

as_bool() {
	local boolean_result=$TRUE;
	`[ ${@} ]` || boolean_result=$FALSE;
	echo $boolean_result;
}

rootcheck() {
	[ $(id -u) -eq 0 ] || false;
}

# Tries to re-run the script in which has been called as the root user
# Usage:
# 	rootcheck_unsafe "${@}"
rootcheck_rerun() {
	# if not a root
	if rootcheck; then
		# re-enter the program, ask for the password (-k)
		exec sudo -k "${0}" "${@}"
		exit $?
	fi
}

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

