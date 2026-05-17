#!/bin/sh
set -u

#  Must be executed as root,
#  because sudo/doas/derivative can and will time out
#
if [ "$(id -u)" -gt 0 ]; then
	echo " ! Executor is not root, exit"
	exit 1
fi

#  Not the best handler, but narrows possibility down
#  that script is nexecuted in not source directory

if [ ! -f .config ]; then
	echo ' ! Missing .config, exit'
	exit 1
fi

readonly _KERNEL_CONF='/etc/kernel.conf'
if [ ! -f "$_KERNEL_CONF" ]; then
	echo " ! $_KERNEL_CONF not found, exit"
	exit 1
fi

_START=0
_POWEROFF_TASK_FILE='/tmp/poweroff'
_REBOOT_TASK_FILE='/tmp/reboot'
rm -f "$_POWEROFF_TASK_FILE" "$_REBOOT_TASK_FILE"

_find_flag() {
	[ "$#" -le 0 ] && return

	while [ "$#" -gt 0 ]; do
		case "$1" in
		"--start") export _START=1 ;;
		"--poweroff") sudo touch "$_POWEROFF_TASK_FILE" ;;
		"--reboot") sudo touch "$_REBOOT_TASK_FILE" ;;
		esac
		shift
	done
}

_sync_story() {
	if [ -z "$1" ]; then
		echo " ! Main branch unspecified"
		exit 1
	fi
	_MAIN_BRANCH="$1"

	git fetch origin
	git checkout "$1" || exit 1
	git reset --hard
}
decide_dir() {
	case "$1" in
	*"-gentoo-dist"*)
		INSTALL_PATH="$_GENTOO_KERNEL_DIR"
		echo " * Gentoo kernel found, install path modified"
		;;
	*"-zen"*)
		INSTALL_PATH="$_ZEN_KERNEL_DIR"
		_sync_story '7.0/main'
		echo " * Zen kernel found, install path modified"
		;;
	*)
		INSTALL_PATH="$_BOOT_DIR"
		echo " * Unregistered kernel found, install path unmodified"
		;;
	esac
	mkdir -p "$INSTALL_PATH"
	export INSTALL_PATH
}
commence_compile() {
	echo '>>> Clean'
	make clean cleandocs
	echo '>>> Build'
	make --jobs=6 --load-average=12 vmlinux modules bzImage
	echo '>>> Install'
	make modules_install install
}
main() {
	_find_flag "$@"

	echo " * Source $_KERNEL_CONF"
	. "$_KERNEL_CONF"

	if [ "$_START" -gt 0 ]; then
		decide_dir "$(make kernelrelease)"
		commence_compile

		[ -f "$_REBOOT_TASK_FILE" ] && loginctl reboot
		[ -f "$_POWEROFF_TASK_FILE" ] && loginctl poweroff
	else
		echo ' * Update existing config'
		make oldconfig
		echo ' * Start config'
		make nconfig
	fi
}

main "$@"
