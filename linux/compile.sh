#!/bin/sh
set -eu

#  Must be executed as root,
#  because sudo/doas/derivative can and will time out
if [ "$(id -u)" -gt 0 ]; then
	echo " ! Executor is not root, exit"
	exit 1
fi

#  Not the best handler, but narrows possibility down
#  that script is nexecuted in not source directory
if [ ! -f .config ]; then
	echo ' ! Missing config, exit'
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
	git checkout "$_MAIN_BRANCH" || exit 1
	git reset --hard "$_MAIN_BRANCH"
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
	echo " * Source $_KERNEL_CONF"
	. "$_KERNEL_CONF"

	_find_flag "$@"

	if [ "$_START" -gt 0 ]; then
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
