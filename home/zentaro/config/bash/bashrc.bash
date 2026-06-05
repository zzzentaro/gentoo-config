[[ $- != *i* ]] && return
# THIS IS A BASHRC

if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc

alias x='sync; clear -x; exec bash'
alias s='sudo'
alias root='sudo su -'

alias l='eza -Ahl --group-directories-first --git'
alias c='cd'
alias ..='cd ..'
alias ...='cd ../..'
alias md='mkdir -p'
alias cp='cp -i'
alias rm='rm -i'

alias gr=grep
alias wcp='wl-copy'

alias mine="chown -R $(id -un):$(id -gn)"

# Devel
alias e="$EDITOR"
alias es="sudoedit"

alias z='tmux attach 2>/dev/null || tmux'
alias g='git'
alias lg='lazygit'
alias cg='cd ~/gentoo-config'
alias cgh='cd ~/gentoo-config/home/zentaro'

alias cksh='shellcheck -s sh'
alias fmtsh='shfmt -w -s'
alias cksh='shellcheck -s sh'
alias fmtsh='shfmt -w -s'

## Gentoo
alias manifest='sudo pkgdev manifest && mine .'

# Control
alias scr='brightnessctl set'
vol() {
	local sink='@DEFAULT_SINK@'
	local src='@DEFAULT_SOURCE@'

	local option="$1"
	local value="$2"

	if [[ $option != 'in' && $option != 'out' ]]; then
		pactl get-sink-volume "$sink" &&
			echo "Output: $(pactl get-sink-mute $sink)" &&
			echo &&
			pactl get-source-volume "$src" &&
			echo "Input: $(pactl get-source-mute $src)"
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

# Portage, The Heart of Gentoo!
alias p='portage'

alias cycle='portage sync; portage update; portage fix; portage clean'
alias recycle='portage sync; portage rebuild; portage update; portage fix; portage clean'

alias etup='sudo etc-update'
alias enup='sudo env-update'
alias dpco='sudo dispatch-conf'

alias world='cat /var/lib/portage/world'
alias worldmod="sudoedit /var/lib/portage/world"
alias sets='cat /var/lib/portage/world_sets'
alias setsmod="sudoedit /var/lib/portage/world_sets"

# Other aliases
alias ff='fastfetch'
## Waydroid
alias wd-stop='sudo waydroid session stop && sudo rc-service waydroid stop'
alias wd-start='wd-stop && sudo rc-service waydroid start && waydroid show-full-ui'

alias nvidia-status='cat /sys/bus/pci/devices/0000\:01\:00.0/power/runtime_status'

# Finally, start interactive shell
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/config.jsonc)"
[[ "$SHLVL" -le 2 && "$WAYLAND_DISPLAY" ]] && fastfetch
