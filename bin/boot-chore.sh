#!/bin/sh
set -eu
. /etc/kernel.conf

# pretend is mostly for testing
_PRETEND=0
_mv() {
	if [ "$_PRETEND" -gt 0 ]; then
		return 0
	else
		sudo mv "$@"
	fi
}

temp_old_file() {
	__KERNEL_DIR="$1"
	__FILE_NAME="$2"

	[ -z "$__KERNEL_DIR" ] && echo "[ !! ] No file directory passed" && return 1
	[ -z "$__FILE_NAME" ] && echo "[ !! ] No file name passed" && return 1

	__OLD_FILE="$__KERNEL_DIR/$__FILE_NAME"
	if [ -f "$__OLD_FILE" ]; then
		_mv "$__OLD_FILE" "$_TEMP_DIR"
		echo "[done] mv $__OLD_FILE $_TEMP_DIR"
	else
		echo "[ !! ] Old file; $__OLD_FILE, does not exist"
		echo "[info] Skipping..."
	fi
}
insert_new_file() {
	__KERNEL_DIR="$1"
	__NEW_FILE="$2"

	[ -z "$__KERNEL_DIR" ] && echo "[ !! ] No file directory passed" && return 1
	[ -z "$__NEW_FILE" ] && echo "[ !! ] No file name passed" && return 1

	[ ! -d "$__KERNEL_DIR" ] && echo "[ !! ] $__KERNEL_DIR does not exist" && return 1
	[ ! -f "$_BOOT_DIR/$__NEW_FILE" ] && echo "[ !! ] $__NEW_FILE does not exist" && return 1

	_mv "$_BOOT_DIR/$__NEW_FILE" "$__KERNEL_DIR"
	echo "[done] mv $_BOOT_DIR/$__NEW_FILE $__KERNEL_DIR"
}
audit_file() {
	__LABEL="$1"

	[ -z "$__LABEL" ] && echo "[ !! ] No label passed" && return 1

	case "$__LABEL" in
	"$_GENTOO_KERNEL")
		__FILE_DIR="$_GENTOO_KERNEL_DIR"
		;;
	"$_ZEN_KERNEL")
		__FILE_DIR="$_ZEN_KERNEL_DIR"
		;;
	*)
		echo "[ !! ] Unkown label: $__LABEL"
		return 1
		;;
	esac

	for type in vmlinuz initramfs config System.map; do
		if [ "$type" = 'initramfs' ]; then
			__FILE_NAME="$type-$__LABEL.img"
		else
			__FILE_NAME="$type-$__LABEL"
		fi
		echo "# $__FILE_NAME"

		temp_old_file "$__FILE_DIR" "$__FILE_NAME"
		insert_new_file "$__FILE_DIR" "$__FILE_NAME"
	done
}
main() {
	for label in $_GENTOO_KERNEL $_ZEN_KERNEL; do
		audit_file "$label"
	done
}
main
