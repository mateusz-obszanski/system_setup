# Recipes:
# to_multiline: '$(echo <someting> | tr -s "\n")'

# Notes:
# functions must set+e at the end if they set -e at the beginning,
# otherwise using them makes e.g. tab-completion shutdown the terminal

set -o errexit -o nounset

fexplorer() {
  if [ -z "$@" ]; then
    xdg-open .
  else
    xdg-open $@
  fi
}

alias fex=fexplorer

catless() {
  local filepath="$1"

  if [ -z "$filepath" ]; then
    # nothing to cat
    exit 1
  fi

  cat "$filepath" | less
}

alias cls=catless

as_bool() {
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

# Install from OS distribution repository
alias dinstall="sudo apt install -y"
alias dupdate="sudo apt update"
alias dupinstall="dupdate && dinstall"
alias dupgrade="sudo apt upgrade -y"

alias to_multiline='tr -s "\n"'

mapcmd() {
  local f="$1"
  shift

  if [ "$1" = "--" ]; then
    local args=$(echo "$2" | xargs)
  else
    local args=$@
  fi

  # multiline
  for a in $(echo $args | to_multiline); do
    "$f" "$a"
  done
}

clean_utils_aliases() {
  local to_unset=$(
    cat <<-EOF
    dinstall dupdate dupinstall dupgrade
EOF
  )

  to_unset=$(echo "$to_unset" | tr -s ' ')

  mapcmd unalias -- $to_unset
  # deregister this function by itself
  unset -f clean_utils_aliases
}

command_exists() {
  local cmdname="$1"
  [ ! -z $(command -v "$cmdname") ]
}
