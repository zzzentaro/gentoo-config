[[ -f ~/.bashrc ]] && source ~/.bashrc

export PATH="$HOME/.local/bin:$PATH"
export HISTCONTROL=ignoreboth

# export QT_QPA_PLATFORM=wayland
# export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

export EDITOR=micro

clear
figlet "welcome home $USER!!"

if [[ -z ${WAYLAND_DISPLAY} ]] && [[ ${XDG_VTNR} -eq 1 ]]; then
  dbus-run-session sway --unsupported-gpu
fi

