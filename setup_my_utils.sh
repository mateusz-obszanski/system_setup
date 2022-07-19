main() {
	local target=~/my/dev/shell
	if [ ! -d "$target" ]; then
		mkdir -p "$target"
	fi
	cp ./my_utils.sh "$target"
}

main

