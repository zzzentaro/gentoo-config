# THIS IS A BASH PROFILE

export PATH="$HOME/.local/bin:$PATH"
[[ -f '~/.bashrc' ]] && source ~/.bashrc

export EDITOR='nano'
command -v vim >/dev/null && export EDITOR='vim' && mkdir -p ~/.vim/{undo,swap,backup}
command -v nvim >/dev/null && export EDITOR='nvim'
export SUDO_EDITOR="$EDITOR"

[[ -z "$WAYLAND_DISPLAY" ]] && [[ "$XDG_VTNR" -eq 1 ]] && dbus-run-session start-hyprland
