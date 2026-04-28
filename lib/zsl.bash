#!/usr/bin/env bash
# Zentaro's Shell Library

zsl-error() {
	echo "[ !! ] ${1:-Invalid option}" >&2
	exit "${2:-1}"
}
zsl-success() {
	echo "[ ok ] ${1:-Operation succeeded}"
	exit 0
}
zsl-require-not-root() {
	[[ $USER == 'root' ]] && zsl-error "Do not run ${0##*/} as root"
}
zsl-require-home() {
	[[ -z "$HOME" ]] && zsl-error '$HOME is not set'
}
zsl-require-command() {
	command -v "$1" >/dev/null || zsl-error "Required command not found: $1"
}
