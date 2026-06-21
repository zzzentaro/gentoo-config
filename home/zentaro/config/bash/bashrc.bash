[[ "$-" != *i* ]] && return

if [[ -d ~/.bashrc.d ]]; then
	for rc in ~/.bashrc.d/*; do
		[[ -f "$rc" ]] && source -- "$rc"
	done
fi
unset rc

alias x="sync; clear; exec $SHELL"
alias s='sudo'

alias l='eza -Ahl --group-directories-first --git'
alias c='cd'
alias ..='cd ..'
alias ...='cd ../..'
alias md='mkdir -p'

alias mine="chown -R $(id -un):$(id -gn)"

alias wcp='wl-copy'

# Devel
alias e="$EDITOR"
alias sue='sudoedit'

alias cg='cd ~/gentoo-config'
alias cgh='cd ~/gentoo-config/home/zentaro'
alias t='tmux attach 2>/dev/null || tmux'
alias g='git'
alias lg='lazygit'

alias cksh='shellcheck -s sh'
alias fmtsh='shfmt -w -s'
alias cksh='shellcheck -s sh'
alias fmtsh='shfmt -w -s'

# Control
alias scr='brightnessctl set'

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

alias manifest='sudo pkgdev manifest'

# Other aliases
alias ff='fastfetch'
## Waydroid
alias wd-stop='sudo -- waydroid -- session stop && sudo -- rc-service -- waydroid stop'
alias wd-start='wd-stop && sudo -- rc-service -- waydroid start && waydroid -- show-full-ui &'

alias nvidia-status='cat /sys/bus/pci/devices/0000\:01\:00.0/power/runtime_status'
alias osu-run='nvidia-offload osu &'

# Finally, start interactive shell
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/config.jsonc)"
[[ "$SHLVL" -le 2 && "$WAYLAND_DISPLAY" ]] && fastfetch
