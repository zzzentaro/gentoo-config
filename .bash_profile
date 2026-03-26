[[ -f ~/.bashrc ]] && source ~/.bashrc

export HISTCONTROL=ignoreboth
export EDITOR=micro

export XCURSOR_PATH=${XCURSOR_PATH}:~/.local/share/icons
export XCURSOR_THEME=BreezeX-RosePineDawn
export XCURSOR_SIZE=48
export WLR_NO_HARDWARE_CURSORS=1

export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='p:preview-tui'

figlet "welcome home $USER!!"

if [[ -z ${WAYLAND_DISPLAY} ]] && [[ ${XDG_VTNR} -eq 1 ]]; then
  dbus-run-session sway --unsupported-gpu
fi

