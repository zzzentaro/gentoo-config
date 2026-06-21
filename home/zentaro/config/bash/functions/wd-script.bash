wd-script() {
	_CLONE=0
	while getopts 'c' opt; do
		case "$opt" in
		c) _CLONE=1 ;;
		*) return 1 ;;
		esac
	done
	shift $((OPTIND - 1))

	_repo='https://github.com/i-am-very-smart/waydroid_script.git'
	_out="${HOME:?no home}/.local/share/waydroid_script"

	if [[ "$_CLONE" -gt 0 ]]; then
		sudo rm -fr "${_out:?no out}"
		git clone --depth=1 -- "$_repo" "$_out"
	fi
	unset _CLONE

	cd "$_out"
	python -m venv venv
	venv/bin/pip install -r requirements.txt
	sudo -- venv/bin/python3 main.py
}
