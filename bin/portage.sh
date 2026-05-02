#!/bin/sh
set -eu
# I barely even need this anymore nowadays, lol

. "$HOME"/.local/lib/zsl || {
	echo '[!!] zsl is missing'
	exit 1
}

readonly _PORTAGE_DIR='/etc/portage'

_no_args_second() {
	[ -z "$2" ] && zsl_error "Nothing to $1 with $0"
}

portage_sync() {
	sudo rm -f /var/db/repos/gentoo/metadata/timestamp.x
	sudo emerge-webrsync
	sudo -v
	sudo emaint sync -A
}

portage_rebuild() {
	sudo emerge @preserved-rebuild
	sudo emerge @module-rebuild
	sudo revdep-rebuild
}

portage_update() {
	sudo emerge --ask --update --newuse --deep --with-bdeps=y --tree @world
}

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
	if [ -z "$2" ]; then
		cat /var/db/repos/gentoo/profiles/use.desc
	else
		${rg:-grep} "$1" /var/db/repos/gentoo/profiles/use.desc
	fi
}

portage_kernel() {
	if [ -z "$2" ]; then
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
	if emerge --ask --pretend --autounmask "$2"; then
		sudo emerge "$2"
	fi
}

portage_unmerge() {
	_no_args_second "$@"

	sudo emerge --ask --deselect "$2" && sudo emerge --depclean
}

portage_edit() {
	[ -z "$2" ] && sudo "$EDITOR" "$_PORTAGE_DIR/make.conf" && return

	_TARGET_DIR=''
	case "$2" in
	use) _TARGET_DIR="$_PORTAGE_DIR/package.use/" ;;
	mask) _TARGET_DIR="$_PORTAGE_DIR/package.mask/" ;;
	unmask) _TARGET_DIR="$_PORTAGE_DIR/package.accept_keywords/" ;;
	sets) _TARGET_DIR="$_PORTAGE_DIR/sets/" ;;
	env) _TARGET_DIR="$_PORTAGE_DIR/env/" ;;
	*) echo "Usage: $0 edit [ use | unmask | sets ] [ ... ]" ;;
	esac
	[ ! -d "$_TARGET_DIR" ] && sudo mkdir -p "$_TARGET_DIR"

	if [ -z "$3" ]; then
		ls -Ahl "$_TARGET_DIR"
	else
		sudo "${EDITOR:-nano}" "$_TARGET_DIR/$3"
	fi
}
portage_help() {
	echo "Usage:"
	echo "   $0 < sync | rebuild | update | clean >"
	echo "   $0 [ search | usedesc | kernel | repo ] [ ... ]"
	echo "   $0 [ merge | unmerge | edit ] [ ... ]"
}

_cmd="portage_$1"
if command -v "$_cmd" >/dev/null; then
	"$_cmd" "$@"
	exit 0
else
	portage_help
	ping -c 3 gentoo.org
	exit 1
fi
