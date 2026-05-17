# Zentaro's eXecutables Yearn

_disable_colours() {
	unset ALL_OFF BOLD BLUE GREEN RED YELLOW
}
_enable_colours() {
	if tput setaf 0 >/dev/null 2>&1; then
		ALL_OFF="$(tput sgr0)"
		BOLD="$(tput bold)"
		RED="${BOLD}$(tput setaf 1)"
		GREEN="${BOLD}$(tput setaf 2)"
		YELLOW="${BOLD}$(tput setaf 3)"
		BLUE="${BOLD}$(tput setaf 4)"
	else
		ALL_OFF="\033[0m"
		BOLD="\033[1m"
		RED="${BOLD}\033[31m"
		GREEN="${BOLD}\033[32m"
		YELLOW="${BOLD}\033[33m"
		BLUE="${BOLD}\033[34m"
	fi
	readonly ALL_OFF BOLD BLUE GREEN RED YELLOW
}
if [ -t 2 ]; then
	_enable_colours
else
	_disable_colours
fi

zxy_log() {
	[ -z "$1" ] && return 1

	__MSG="$1"
	__CODE="${2:-0}"

	__KEY='--'
	__COLOUR="$BLUE"
	if [ "$__CODE" -eq 1 ] || [ "$__CODE" -eq 3 ]; then
		__COLOUR="$RED"
		__KEY='!!'
	fi

	if [ "$__CODE" -eq 2 ] || [ "$__CODE" -eq 3 ]; then
		printf '%s %s %s%s' "$__COLOUR" "$__KEY" "$__MSG" "$ALL_OFF"
	else
		printf '%s %s %s%s\n' "$__COLOUR" "$__KEY" "$__MSG" "$ALL_OFF"
	fi
}

zxy_is_root() {
	if [ "$(id -u)" -le 0 ]; then
		return 0
	else
		return 1
	fi
}
zxy_need_user() {
	if zxy_is_root; then
		zxy_log "Do not run as root"
		exit 1
	fi
}
zxy_need_home() {
	if [ -z "$HOME" ]; then
		zxy_log 'Environment variable HOME undefined'
		exit 1
	fi
}
zxy_need_command() {
	__MISSING=''
	for cmd in "$@"; do
		if ! command -v "$cmd" >/dev/null 2>&1; then
			__MISSING="$__MISSING $cmd"
		fi
	done

	[ -z "$__MISSING" ] && return 0

	zxy_log "Missing dependencies:$__MISSING" 1
	exit 1
}
