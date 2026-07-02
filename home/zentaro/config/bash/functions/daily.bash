daily()
{
	while getopts 'sr' opt; do
		case "$opt" in
		s)
			sudo emaint sync
			;;
		r)
			portage rebuild
			sudo revdep-rebuild
			;;
		*) return 1 ;;
		esac
	done
	shift $((OPTIND - 1))

	portage-sets-refresh
	sudo emerge -auND --with-bdeps=y @world
	portage fix
	portage clean
}
