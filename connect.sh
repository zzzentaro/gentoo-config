#!/bin/sh
# THIS SCRIPT IS PERSONAL USE AND DESTRUCTIVE
set -eu

log() {
	__msg="$1"
	[ -z "$__msg" ] && log 'Nothing to log' 1

	__code="${2:-0}"
	__key='--'
	[ "$__code" -gt 0 ] && __key='!!'

	printf ' %s %s\n' "$__key" "$__msg"
	[ "$__code" -ge 2 ] && exit 1
	return "$__code"
}

# Evaluate
[ "$(id -u)" -eq 0 ] && log 'Do not run as root' 2
[ -z "$HOME" ] && log 'HOME not found' 2

# SETUP
_HERE="$(cd "$(dirname "$0")" && pwd)"
readonly _HERE
readonly _MY_STORE="$_HERE/home/zentaro"

backup() {
	[ "$#" -lt 1 ] && log 'Nothing to backup' 1

	__backup_dir="$_HERE/tmp"
	mkdir -p -- "$__backup_dir"
	for item in "$@"; do
		log "Backup $item"
		rm -rf -- "$__backup_dir/$(basename "$item")"
		mv -- "$item" "$__backup_dir" || log "Failed to backup $item" 1
	done
}
linkin() { # link (inside) + log
	[ "$#" -lt 2 ] && log 'Not enough args' 1

	__from="$1"
	[ ! -e "$__from" ] && log "$__from does not exist" 1

	__to="$2"

	if [ "$#" -ge 3 ]; then
		__ro_from="$__from"
		__ro_to="$__to"

		shift 2
		for item in "$@"; do
			linkin "$__ro_from/$item" "$__ro_to/$item"
		done
	else
		[ ! -L "$__to" ] && [ -e "$__to" ] && backup "$__to"
		log "Link $(basename "$__from")"
		ln -sfn -- "$__from" "$__to" || log "Failed to link $__from $__to" 1
	fi
}

# XDG_CONFIG_HOME
readonly _MY_CONFIG_STORE="$_MY_STORE/config"

## Bash is special
log 'CONNECTING BASH...' 1 || true
_bash_store="$_MY_CONFIG_STORE/bash"
_bash_home="$HOME"
linkin "$_bash_store/profile.bash" "$_bash_home/.bash_profile"
linkin "$_bash_store/bashrc.bash" "$_bash_home/.bashrc"
linkin "$_bash_store/logout.bash" "$_bash_home/.bash_logout"

log 'CONNECTING CONFIG...' 1 || true
readonly _CONFIG_HOME="$HOME/.config"
mkdir -p -- "$_CONFIG_HOME"
linkin "$_MY_CONFIG_STORE" "$_CONFIG_HOME" \
	alacritty \
	fastfetch \
	fuzzel \
	hypr \
	mako \
	nvim \
	oh-my-posh \
	vim \
	waybar
#sway \
#swaylock \
#vesktop \
#yazi

log 'CONNECTING LOCAL...' 1 || true
readonly _lib_store="$_MY_STORE/local/lib" _lib_home="$HOME/.local/lib"
readonly _bin_store="$_MY_STORE/local/bin" _bin_home="$HOME/.local/bin"
mkdir -p -- "$_lib_home" "$_bin_home"

linkin "$_lib_store" "$_lib_home" zxy
linkin "$_bin_store" "$_bin_home" \
	install-millennium \
	install-osu \
	menu \
	nvidia-offload \
	portage \
	portage-sets-refresh \
	rc-user \
	theme \
	uninstall-millennium \
	zen-kernel
