#!/bin/sh
set -u

readonly _GENTOO_REPOSITORY='/var/db/repos/gentoo'
readonly _ZENTOO_REPOSITORY='/home/zentaro/src/zentoo'
readonly _VANILLA="$_GENTOO_REPOSITORY/sys-kernel/vanilla-kernel"
readonly _DIST="$_GENTOO_REPOSITORY/virtual/dist-kernel"
readonly _GENTOO="$_GENTOO_REPOSITORY/sys-kernel/gentoo-kernel"
readonly _GENTOO_DIST="$_GENTOO_REPOSITORY/sys-kernel/gentoo-kernel-bin"
readonly _ZEN="$_GENTOO_REPOSITORY/sys-kernel/zen-sources"

copy_kernels() {
	if [ -z "$1" ]; then
		echo "[ !! ] No package given"
		return 1
	elif [ -z "$2" ]; then
		echo "[ !! ] No version given"
		return 1
	elif [ -z "$3" ]; then
		echo "[ !! ] No destination given"
		return 1
	fi
	_PACKAGE="$1"
	_VERSION="$2"
	_DESTINATION="$3"

	if [ "$_PACKAGE" = 'dist-kernel' ]; then
		_CATEGORY='virtual'
	else
		_CATEGORY='sys-kernel'
	fi
	_EBUILD="$_GENTOO_REPOSITORY/$_CATEGORY/$_PACKAGE/$_PACKAGE-$_VERSION.ebuild"
	_DESTINATION="$_DESTINATION/$_CATEGORY/$_PACKAGE"

	if [ -f "$_EBUILD" ]; then
		mkdir -p "$_DESTINATION"
		echo " * Copy $_EBUILD to $_DESTINATION"
		cp "$_EBUILD" "$_DESTINATION"
	else
		echo "[ !! ] Not found: $_EBUILD"
		return 1
	fi
}
main() {
	if [ -z "${1:-}" ]; then
		echo "[ !! ] No version given"
		return 1
	fi
	_VERSION="$1"

	for package in vanilla-kernel dist-kernel gentoo-kernel gentoo-kernel-bin zen-sources; do
		copy_kernels "$package" "$_VERSION" "$_ZENTOO_REPOSITORY"
	done

}
main "$@"
