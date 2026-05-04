# Zentaro's Shell Library

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

zsl_log() {
	_colour="$1"
	_log_type="$2"
	_log_msg="$3"
	_exit_code="${4:-0}"

	# send to stderr if the type is error
	if [ "$_log_type" = "!!" ]; then

		printf "%s[%s] %s%s\n" "$_colour" "$_log_type" "$_log_msg" "$ALL_OFF" >&2
	else
		printf "%s[%s] %s%s\n" "$_colour" "$_log_type" "$_log_msg" "$ALL_OFF"

	fi
	return "$_exit_code"
}
zsl_error() {
	zsl_log "$RED" ' !! ' "${1:-Unknown error}" "${2:-1}"
}
zsl_success() {
	zsl_log "$GREEN" ' ok ' "${1:-Operation success}" 0
}
zsl_info() {
	zsl_log "$YELLOW" 'info' "${1:-Additional information}" 0
}

zsl_is_root() { [ "$(id -u)" -eq 0 ]; }
zsl_need_user() {
	zsl_is_root && zsl_error "Do not run as root" || return 0
}
zsl_need_home() {
	[ -z "$HOME" ] && zsl_error '$HOME not found'
}
zsl_need_command() {
	command -v "$1" >/dev/null || zsl_error "Missing dependency: $1"
}
