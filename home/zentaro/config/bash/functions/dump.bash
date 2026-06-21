dump() {
	_dump="$HOME/Pictures/dump"
	_char="$1"
	_author="$2"
	_src="$3"
	_ext="${4:-jpg}"

	_platform=''
	case "$_src" in
	*twimg*)
		_platform='x'
		;;
	*pximg*)
		_platform='pixiv'
		;;
	*)
		_platform='unk'
		;;
	esac

	_out="$_dump/$_char-$_author-$_platform-$(date +%s).$_ext"
	wget "$_src" -o "$_out"
}
