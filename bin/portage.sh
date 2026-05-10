#!/bin/sh
set -u
readonly _CMD="portage"

. "${HOME}/.local/lib/zsl" || {
	echo "[!!] zsl is missing"
	exit 1
}
zsl_need_command 'emerge'

readonly _PORTAGE_DIR='/etc/portage'

_need_second_args() {
	if [ -z "${2:-}" ]; then
		zsl_error "Nothing to $1 with $_CMD"
		exit 1
	fi
}
_start() {
	zsl_info "Initialise ${_CMD:-} ${1:-} ..."
	sudo -v
}
# pretend is mostly for testing
_PRETEND=0
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
	_start "$1"

	_web_rsync
	_emaint_sync
	_health_check

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
	_start "$1"

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
	_start "$1"
	sudo emerge --verbose --ask --update --newuse --deep --with-bdeps=y --tree @world
}

# PORTAGE CLEAN
portage_clean() {
	_start "$1"

	sudo emerge --ask --depclean
	sudo -v
	sudo eclean-dist --deep
	sudo -v
	sudo eclean-pkg --deep
	sudo -v
	sudo eclean-kernel
}

# PORTAGE FIND
_search() {
	zsl_info "Entry(s) for ${1:-}"
	if command -v eix >/dev/null; then
		EIX_LIMIT=1 eix "$1"
	else
		emerge --search "$1"
	fi

}
_query() {
	if command -v equery >/dev/null; then
		zsl_info "Flag(s) for $1"
		equery u "$1"
	fi
}
_find() {
	shift
	for package in "$@"; do
		_search "$package"
		_query "$package"
	done
}
portage_find() {
	_need_second_args "$@"
	_find "$@"
}

# PORTAGE USEDESC
portage_usedesc() {
	_USEDESC_FILE='/var/db/repos/gentoo/profiles/use.desc'
	if [ -z "${2:-}" ]; then
		cat "$_USEDESC_FILE"
	else
		for flag in "$@"; do
			${rg:-grep} "$flag" /var/db/repos/gentoo/profiles/use.desc
		done
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
	_need_second_args "$@"

	if command -v equery >/dev/null; then
		equery u "$2"
	fi
	sudo emerge --verbose --ask --autounmask "$2"
}

portage_unmerge() {
	_need_second_args "$@"

	sudo emerge --ask --deselect "$2" && sudo emerge --depclean
}

# PORTAGE EDIT
readonly _MAKE_CONF="$_PORTAGE_DIR/make.conf"
_edit_make_conf() {
	sudoedit "$_MAKE_CONF" 2>/dev/null || sudo -E "$EDITOR" "$_MAKE_CONF"
}
_select_target_dir() {
	case "${1:-}" in
	use) _SUB="package.use" ;;
	mask) _SUB="package.mask" ;;
	unmask) _SUB="package.accept_keywords" ;;
	sets) _SUB="sets" ;;
	env) _SUB="env" ;;
		# TODO: refactor usage
	*) echo "Usage: $_CMD edit [ use | unmask | sets ] [ ... ]" ;;
	esac
	_TARGET_DIR="$_PORTAGE_DIR/${_SUB:-?}"
	readonly _TARGET_DIR
	[ -d "$_TARGET_DIR" ] || sudo mkdir -p "$_TARGET_DIR"
	echo "$_TARGET_DIR"
}
portage_edit() {
	[ -z "${2:-}" ] && _edit_make_conf && return
	[ -z "${3:-}" ] && echo "# TODO: refactor usage" && return 1

	readonly _ITEM="$(_select_target_dir "${2:-?}")/${3:-}"
	sudoedit "$_ITEM"
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
