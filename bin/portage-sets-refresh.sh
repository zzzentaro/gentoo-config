#!/bin/sh
set -u
. "$HOME"/.local/lib/zsl || {
	echo '[!!] zsl is missing'
	exit 1
}
zsl_need_command 'emerge'
zsl_need_user

readonly _SETS_DIR='/etc/portage/sets'

_query_sets() {
	for _set in "$_SETS_DIR/"*; do
		"$@" "$_set"
	done
}

_select_one_set() {
	_SELECTED_SET="$(basename "$1")"
	zsl_info "Selected set: @$_SELECTED_SET"
	sudo emerge --noreplace "@$_SELECTED_SET"
}
portage_sets_select() {
	_query_sets _select_one_set
}

_is_empty_or_comment() {
	case "$1" in
	'' | '#'*) return 0 ;;
	*) return 1 ;;
	esac
}
_read_set_and_deselect_atom() {
	_SELECTED_SET="$(basename "$1")"
	zsl_info "Deselecting atom(s) in: @$_SELECTED_SET"
	while IFS= read -r _line; do
		_is_empty_or_comment "$_line" && continue
		sudo emerge --deselect "$_line"
	done <"$1"
}
portage_atom_deselect() {
	_query_sets _read_set_and_deselect_atom
}

portage_sets_select
portage_atom_deselect
