#!/usr/bin/env bash
FN="portage"
source "$HOME"/.local/lib/zsl || {
	echo '[!!] zsl is missing'
	exit 1
}

check-argument-second() {
	[[ -z $2 ]] && zsl-error "Nothing to $1 with $FN"
}

portage-sync() {
	sudo rm -f /var/db/repos/gentoo/metadata/timestamp.x
	sudo emerge-webrsync
	sudo -v
	sudo emaint sync -A

}

portage-rebuild() {
	sudo emerge '@preserved-rebuild'
	sudo emerge '@module-rebuild'
	sudo revdep-rebuild
}

portage-update() {
	sudo emerge --ask --update --newuse --deep --with-bdeps=y --tree '@world'
}

portage-clean() {
	sudo emerge --ask --depclean
	sudo -v
	sudo eclean-dist --deep
	sudo -v
	sudo eclean-pkg --deep
	sudo -v
	sudo eclean-kernel
}

portage-search-true() {
	echo "[$FN] Found entry(s) for '$2'"
	if command -v eix >/dev/null; then
		eix "$2"
	else
		emerge --search "$2"
	fi
	if command -v equery >/dev/null; then
		echo "[$FN] Flag(s) for '$2'"
		equery u "$2"
	fi

}
portage-search() {
	check-argument-second "$@" # see line 8
	portage-search-true "$@"   # look above
}

portage-usedesc() {
	if [[ -z $2 ]]; then
		cat '/var/db/repos/gentoo/profiles/use.desc'
	else
		${rg:-grep} "$1" /var/db/repos/gentoo/profiles/use.desc
	fi
}

portage-kernel() {
	if [[ -z $2 ]]; then
		echo "[$FN] sources inside /usr/src/"
		ls -Ahl '/usr/src'
		echo
	else
		sudo eselect kernel set "$2"
	fi
	eselect kernel list
}

portage-repo() {
	eselect repository list -i
}

portage-merge() {
	check-argument-second "$@" # see line 8

	if command -v equery >/dev/null; then
		equery u "$2"
	fi
	sudo emerge --ask --autounmask "$2"
}

portage-unmerge() {
	check-argument-second "$@" # see line 8

	sudo emerge --ask --deselect "$2" && sudo emerge --depclean
}

portage-edit() {
	[[ -z $2 ]] && sudo "$EDITOR" /etc/portage/make.conf && return

	local target_dir=''
	case "$2" in
	use) target_dir='/etc/portage/package.use/' ;;
	mask) target_dir='/etc/portage/package.mask/' ;;
	unmask) target_dir='/etc/portage/package.accept_keywords/' ;;
	sets) target_dir='/etc/portage/sets/' ;;
	env) target_dir='/etc/portage/env/' ;;
	*) echo "Usage: $FN edit [ use | unmask | sets ] [ ... ]" ;;
	esac
	[[ ! -d $target_dir ]] && sudo mkdir -p "$target_dir"

	if [[ -z $3 ]]; then
		ls -Ahl "$target_dir"
	else
		sudo ${EDITOR:-nano} "$target_dir/$3"
	fi
}
portage-help() {
	echo "[$FN] I tried putting all Portage tools in a box."
	echo "Usage:"
	echo "   $FN < sync | rebuild | update | clean >"
	echo "   $FN [ search | usedesc | kernel | repo ] [ ... ]"
	echo "   $FN [ merge | unmerge | edit ] [ ... ]"
}

if declare -f "portage-$1" >/dev/null; then
	"portage-$1" "$@"
	exit
else
	portage-help
	ping -c 3 gentoo.org
	exit
fi
