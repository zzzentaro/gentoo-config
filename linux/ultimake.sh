#!/bin/sh
set -eu

_SRC_DIR="${1:-.}"

#  Must be executed as root,
#  because sudo/doas/derivative can and will time out
if [ "$(id -u)" -gt 0 ]; then
	echo " !! Executor is not root, exit"
	exit 1
fi

#  Not the best handler, but narrows possibility down
#  that script is executed not source directory
if [ ! -f "$_SRC_DIR/.config" ]; then
	echo ' !! Missing config, exit'
	exit 1
fi

_COMPILE=0
_find_flag() {
	while getopts ":c" opt; do
		case "$opt" in
		u) _COMPILE=1 ;;
		?)
			echo "invalid option: '$OPTARG'" >&2
			exit 1
			;;
		esac
	done
}

remake() {
	make --directory="$_SRC_DIR" "$@"
}
compile() {
	echo ' -- Clean'
	remake clean cleandocs
	echo ' -- Build'
	remake --jobs=6 --load-average=12 vmlinux modules bzImage
	echo ' -- Export'
	remake modules_install install
}
main() {
	_find_flag "$@"
	shift $((OPTIND - 1))

	echo ' -- Update existing config'
	remake oldconfig

	if [ "$_COMPILE" -gt 0 ]; then
		compile
	else
		echo ' -- Start config'
		remake nconfig
	fi
}
main "$@"
