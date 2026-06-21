update()
{
	_sync=0
	while getopts "s" opt; do
		case "$opt" in
		s) _sync=1 ;;
		*) return 1 ;;
		esac
	done
	shift $((OPTIND - 1))

	[[ "$_sync" -gt 0 ]] && sudo emaint sync
	portage-sets-refresh
	portage rebuild
	sudo emerge -auND --with-bdeps=y @world
	sudo revdep-rebuild
	portage fix
	portage clean

	flatpak -- update
}
