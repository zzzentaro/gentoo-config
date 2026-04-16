# --- --- --- --- --- --- --- --- ---
# > initialisation of every session
# --- --- --- --- --- --- --- --- ---
export PATH="$HOME/.local/bin:$PATH"

[[ -f ~/.bashrc ]] && source ~/.bashrc && clear

if [[ -z ${WAYLAND_DISPLAY} ]] && [[ ${XDG_VTNR} -eq 1 ]]; then
	dbus-run-session sway --unsupported-gpu
fi

export EDITOR='nano'
command -v vim > /dev/null && export EDITOR='vim'
command -v nvim > /dev/null && export EDITOR='nvim'

mkdir -p ~/.vim/{undo,swap,backup}
