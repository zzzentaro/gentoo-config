volume()
{
	local sink='@DEFAULT_SINK@'
	local src='@DEFAULT_SOURCE@'

	local option="$1"
	local value="$2"

	if [[ $option != 'in' && $option != 'out' ]]; then
		pactl get-sink-volume "$sink" \
			&& echo "Output: $(pactl get-sink-mute $sink)" \
			&& echo \
			&& pactl get-source-volume "$src" \
			&& echo "Input: $(pactl get-source-mute $src)"
		return
	fi

	local target cmd_mute cmd_status
	if [[ $option == 'out' ]]; then
		target="$sink"
		cmd_set='set-sink-volume'
		cmd_mute='set-sink-mute'
		cmd_status='get-sink-mute'
	else
		target="$src"
		cmd_set='set-source-volume'
		cmd_mute='set-source-mute'
		cmd_status='get-source-mute'
	fi

	if [[ -z $value ]]; then
		pactl "$cmd_mute" "$target" toggle
		pactl "$cmd_status" "$target"
		return
	fi

	local val
	[[ $2 =~ ^[0-9]+$ ]] && val="${2}%" || val="$2"
	pactl "$cmd_set" "$target" "$val"
	pactl "$cmd_status" "$target"
	return 0
}
