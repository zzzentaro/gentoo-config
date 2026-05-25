#!/bin/sh
set -eu

exit_wm() {
	command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'
}
menu_power() {
	_POWER_OPTION=$(printf "0) ..\n1) Retreat    󰩈\n2) Retry      \n3) Pause      " |
		fuzzel --dmenu -I -a top -l 4 -w 16 --prompt="󰦄 " --placeholder="Is it over?")
	case "$_POWER_OPTION" in
	*Retreat*)
		exit_wm
		loginctl poweroff
		;;
	*Retry*)
		exit_wm
		loginctl reboot
		;;
	*Pause*) exit_wm ;;
	*) menu ;;
	esac
}

menu_mode() {
	_MODE_OPTION=$(printf "0) ..\n1) DEA-Y      \n2) GEE-X      󱀣\n3) MAR-X      󰗍" |
		fuzzel --dmenu -I -a top -l 4 -w 16 --prompt=" " --placeholder="Wait a bit...")
	case "$_MODE_OPTION" in
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

option=$(printf "1) Missions   󰦄\n2) Logistics  󰏗\n3) Modules    󰝣" |
	fuzzel --dmenu -I -a top -l 3 -w 16 --prompt=" " --placeholder="Hey, $USER!")
case "$option" in
*Missions*) menu_power ;;
*Logistics*) menu_portage ;;
*Modules*) menu_mode ;;
*) exit ;;
esac
