#!/usr/bin/zsh

set -e

# Args:
# - this script's directory (dirname $0)
main() {
	set -e

    local this_dir="$1"
	local target=~/my/dev/shell

	if [ ! -d "$target" ]; then
		mkdir -p "$target"
	fi

	cp "$this_dir/my_utils.sh" "$target"
}

main $(dirname $0)

