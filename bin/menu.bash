#!/usr/bin/env bash

menu-power() {
	option_power=$(printf "0) ..\n1) Retreat    󰩈\n2) Retry      \n3) Pause      " |
		fuzzel --dmenu -I -a top -l 4 -w 16 --prompt="󰦄 " --placeholder="Is it over?")
	case "$option_power" in
		*Retreat*) loginctl poweroff ;;
		*Retry*) loginctl reboot ;;
		*Pause*) swaymsg exit ;;
		*) menu ;;
	esac
}

menu-mode() {
	option=$(printf "0) ..\n1) DEA-Y      \n2) GEE-X      󱀣\n3) MAR-X      󰗍" |
		fuzzel --dmenu -I -a top -l 4 -w 16 --prompt=" " --placeholder="Wait a bit...")
	case "$option" in
		*DEA-Y*)
			pactl set-source-mute @DEFAULT_SOURCE@ 1
			pactl set-sink-mute @DEFAULT_SINK@ 1
			brightnessctl set 5%
			powerprofilesctl set performance
			;;
		*GEE-X*)
			pactl set-source-mute @DEFAULT_SOURCE@ 0
			pactl set-sink-mute @DEFAULT_SINK@ 0
			pactl set-source-volume @DEFAULT_SOURCE@ 50%
			pactl set-sink-volume @DEFAULT_SINK@ 50%
			brightnessctl set 10%
			powerprofilesctl set balanced
			;;
		*MAR-X*)
			pactl set-source-mute @DEFAULT_SOURCE@ 0
			pactl set-sink-mute @DEFAULT_SINK@ 0
			pactl set-source-volume @DEFAULT_SOURCE@ 50%
			pactl set-sink-volume @DEFAULT_SINK@ 50%
			brightnessctl set 20%
			powerprofilesctl set power-saver
			;;
		*) menu ;;
	esac
}

menu-portage-execute() {
	local cmd="$1"
	local name="$2"

	notify-send -u normal " Portage" "$name starting!!"
	eval "$cmd"

	if [ "$?" -eq 0 ]; then
		notify-send -u normal " Portage" "$name complete!!"
	else
		notify-send -u critical " Portage" "$name failed!!"
	fi

	echo "Press any key to close..."
	read -n 1
}
export -f menu-portage-execute
menu-portage-init() {
	local cmd="$1"
	local label="$2"
	alacritty -T 'floatty' -e bash -c "menu-portage-execute '$cmd' '$label'"
}
menu-portage() {
	option_menu_portage=$(printf "0) ..\n1) Sync       󰑥\n2) Update     󰢛\n3) Clean      " |
		fuzzel --dmenu -I -a top -l 4 -w 16 --prompt=" " --placeholder='High voltage!!')
	case "$option_menu_portage" in
		*Sync*) menu-portage-init "portage sync" "Sync" ;;
		*Update*) menu-portage-init "portage update" "Update" ;;
		*Clean*) menu-portage-init "portage clean" "Clean" ;;
		*) menu ;;
	esac
}

option=$(printf "1) Missions   󰦄\n2) Logistics  󰏗\n3) Modules    󰝣" |
	fuzzel --dmenu -I -a top -l 3 -w 16 --prompt=" " --placeholder="Hey, $USER!")
case "$option" in
	*Missions*) menu-power ;;
	*Logistics*) menu-portage ;;
	*Modules*) menu-mode ;;
	*) exit ;;
esac
