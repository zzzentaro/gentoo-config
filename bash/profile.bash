# --- --- --- --- --- --- --- --- ---
# > initialisation of every session
# --- --- --- --- --- --- --- --- ---
export PATH="$HOME/.local/bin:$PATH"

[[ -f ~/.bashrc ]] && source ~/.bashrc && clear

export EDITOR='nano'
command -v vim >/dev/null && export EDITOR='vim' && mkdir -p ~/.vim/{undo,swap,backup}
command -v nvim >/dev/null && export EDITOR='nvim'

if [[ -z ${WAYLAND_DISPLAY} ]] && [[ ${XDG_VTNR} -eq 1 ]]; then
	dbus-run-session start-hyprland
fi
