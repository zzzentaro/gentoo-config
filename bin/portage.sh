#!/bin/sh
set -eu
. "$HOME"/.local/lib/zsl || {
	echo '[!!] zsl is missing'
	exit 1
}
zsl_need_command 'emerge'
readonly _CMD="${0##*/}"

readonly _PORTAGE_DIR='/etc/portage'

# pretend is mostly for testing
_PRETEND=1
_ASK=0
_emerge() {
	if [ "$_PRETEND" -gt 0 ]; then
		sudo emerge --verbose --pretend "$1"
		return
	fi

	if [ "$_ASK" -gt 0 ]; then
		sudo emerge --verbose --ask "$1"
	else
		sudo emerge --verbose "$1"
	fi
}

_no_args_second() {
	[ -z "${2:-}" ] && zsl_error "Nothing to $1 with $_CMD"
}

# PORTAGE SYNC
_web_rsync() {
	sudo rm -f /var/db/repos/gentoo/metadata/timestamp.x &&
		sudo emerge-webrsync
}
_emaint_sync() {
	sudo emaint sync --allrepos
}
_health_check() {
	sudo etc-update && zsl_success "etc-update"
	sudo env-update && zsl_success "env-update"
	sudo dispatch-conf && zsl_success "dispatch-conf"
	sudo emaint --fix all
}
portage_sync() {
	zsl_info "Starting $_CMD $1"
	sudo -v

	for item in web_rsync emaint_sync health_check; do
		sudo -v
		zsl_info "Starting $item..." &&
			_"$item" &&
			zsl_success "$item complete!" ||
			zsl_error "$item failed"
	done
	zsl_success "$_CMD $1 complete"
}

# PORTAGE REBUILD
_revdep_rebuild() {
	if [ "$_PRETEND" -gt 0 ]; then
		sudo revdep-rebuild --pretend
	else
		sudo revdep-rebuild
	fi
}
_try_revdep_rebuild() {
	command -v revdep-rebuild >/dev/null || return 1

	zsl_info "Starting revdep-rebuild..." &&
		_revdep_rebuild &&
		zsl_success "revdep-rebuild complete!" ||
		zsl_error "revdep-rebuild failed"

}
portage_rebuild() {
	zsl_info "$_CMD"
	sudo -v
	for item in @preserved-rebuild @module-rebuild; do
		sudo -v
		zsl_info "Starting $item..." &&
			_emerge "$item" &&
			zsl_success "$item complete!" ||
			zsl_error "$item failed"
	done
	_try_revdep_rebuild
}

# #PORTAGE UPDATE
portage_update() {
	sudo emerge --verbose --ask --update --newuse --deep --with-bdeps=y --tree @world
}

# PORTAGE CLEAN
portage_clean() {
	sudo emerge --ask --depclean
	sudo -v
	sudo eclean-dist --deep
	sudo -v
	sudo eclean-pkg --deep
	sudo -v
	sudo eclean-kernel
}

portage_search_true() {
	zsl_success "Found entry(s) for $2"
	if command -v eix >/dev/null; then
		eix "$2"
	else
		emerge --search "$2"
	fi
	if command -v equery >/dev/null; then
		zsl_info "Flag(s) for $2"
		equery u "$2"
	fi
}
portage_search() {
	_no_args_second "$@"
	portage_search-true "$@"
}

portage_usedesc() {
	if [ -z "${2:-}" ]; then
		cat /var/db/repos/gentoo/profiles/use.desc
	else
		${rg:-grep} "$2" /var/db/repos/gentoo/profiles/use.desc
	fi
}

portage_kernel() {
	if [ -z "${2:-}" ]; then
		zsl_info "Kernel(s) inside /usr/src/"
		ls -Ahl /usr/src
		echo
	else
		sudo eselect kernel set "$2"
	fi
	eselect kernel list
}

portage_repo() {
	eselect repository list -i
}

portage_merge() {
	_no_args_second "$@"

	if command -v equery >/dev/null; then
		equery u "$2"
	fi
	sudo emerge --verbose --ask --autounmask "$2"
}

portage_unmerge() {
	_no_args_second "$@"

	sudo emerge --ask --deselect "$2" && sudo emerge --depclean
}

portage_edit() {
	[ -z "${2:-}" ] && sudo "$EDITOR" "$_PORTAGE_DIR/make.conf" && return 1

	_TARGET_DIR=''
	case "${2:-}" in
	use) _TARGET_DIR="$_PORTAGE_DIR/package.use/" ;;
	mask) _TARGET_DIR="$_PORTAGE_DIR/package.mask/" ;;
	unmask) _TARGET_DIR="$_PORTAGE_DIR/package.accept_keywords/" ;;
	sets) _TARGET_DIR="$_PORTAGE_DIR/sets/" ;;
	env) _TARGET_DIR="$_PORTAGE_DIR/env/" ;;
	*) echo "Usage: $_CMD edit [ use | unmask | sets ] [ ... ]" ;;
	esac
	[ ! -d "$_TARGET_DIR" ] && sudo mkdir -p "$_TARGET_DIR"

	if [ -z "${3:-}" ]; then
		ls -Ahl "$_TARGET_DIR"
	else
		sudo "$EDITOR" "$_TARGET_DIR/$3"
	fi
}
portage_help() {
	echo "Usage:"
	echo "   $_CMD < sync | rebuild | update | clean >"
	echo "   $_CMD [ search | usedesc | kernel | repo ] [ ... ]"
	echo "   $_CMD [ merge | unmerge | edit ] [ ... ]"
}

readonly _FINAL_CMD="${_CMD}_${1:-help}"
if command -v "$_FINAL_CMD" >/dev/null; then
	"$_FINAL_CMD" "$@"
	exit 0
else
	portage_help
	ping -c 3 gentoo.org
	exit 1
fi
