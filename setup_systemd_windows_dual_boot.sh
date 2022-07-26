#!/usr/bin/zsh

set -e

. ~/my/dev/shell/my_utils.sh

main() {
	set -e

	local timeout=5
	local loader_path=/boot/efi/loader/loader.conf
	local mountpoint=/mnt/win-efi

	echo "find Windows EFi partition below and give its name: "
	lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT
	read efi_partition

	if [ ! -d "$mountpoint" ]; then
		echo "mounting $mountpoint"
		sudo mkdir "$mountpoint"
	fi

	sudo mount "/dev/$efi_partition" "$mountpoint" || exit 1
	sudo cp -r "$mountpoint/EFI/Microsoft" /boot/efi/EFI

	local found_timeout=$(sudo grep -E "timeout" "$loader_path")

	if [ -z "$found_timeout" ]; then
		echo "setting boot timeout to $timeout"
		echo "timeout $timeout" | sudo tee -a "$loader_path"
	fi

	echo "unmounting '$mountpoint'"
	sudo umount "$mountpoint"
	sudo rm -rf "$mountpoint"
}

rootcheck_rerun
main
clean_utils_aliases
