[[ -f ~/.bashrc ]] && source ~/.bashrc

export PATH="$HOME/.local/bin:$PATH"
export EDITOR='nvim'
mkdir -p ~/.vim/{undo,swap,backup}

brightnessctl set 20%
powerprofilesctl set power-saver

clear
figlet "welcome home $USER!!"
if [[ -z ${WAYLAND_DISPLAY} ]] && [[ ${XDG_VTNR} -eq 1 ]]; then
	dbus-run-session sway --unsupported-gpu
fi
