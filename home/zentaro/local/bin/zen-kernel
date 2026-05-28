#!/bin/sh
set -eu
. "$HOME/.local/lib/zxy" || {
    printf ' !! zxy is missing\n'
    exit 1
}
zxy_need_command 'sudo' 'git'

readonly _ZEN_KERNEL_GIT='https://github.com/zen-kernel/zen-kernel.git'
readonly _SOURCE_DIR='/usr/src/zen-kernel'
readonly _SYMLINK='/usr/src/linux'

_UPDATE=0
_CONFIG=0
_find_flags() {
    while getopts ":u" opt; do
        case "$opt" in
        u) _UPDATE=1 ;;
        ?)
            echo "invalid option: '$OPTARG'" >&2
            exit 1
            ;;
        esac
    done
}
main() {
    _find_flags "$@"
    shift $((OPTIND - 1))

    if [ "$_UPDATE" -gt 0 ]; then
        zxy_log "Delete $_SOURCE_DIR"
        sudo rm -rf "$_SOURCE_DIR"
        sudo git clone --depth=1 "$_ZEN_KERNEL_GIT" "$_SOURCE_DIR"
        sudo ln -sfn "$_SOURCE_DIR" "$_SYMLINK"
    fi

    if [ -d "$_SOURCE_DIR" ]; then
        zxy_log "Zen kernel is installed"
    else
        zxy_log "Zen kernel is not installed" 1
    fi

    if [ "$(readlink -f "$_SYMLINK")" = "$_SOURCE_DIR" ]; then
        zxy_log "$_SYMLINK is linked to $_SOURCE_DIR"
    else
        zxy_log "$_SYMLINK is not linked to $_SOURCE_DIR" 1
    fi
}
main "$@"
