[[ "$-" != *i* ]] && return

if [[ -d ~/.bashrc.d ]]; then
	for rc in ~/.bashrc.d/*; do
		[[ -f "$rc" ]] && source -- "$rc"
	done
fi
unset rc

## Core
alias x="sync; clear; exec $SHELL"
alias s=sudo

## Everything is a file
alias l='eza -Ahl --group-directories-first --git'
alias c=cd
alias ..='cd ..'
alias ...='cd ../..'
alias md='mkdir -p'

alias wcp='wl-copy'

## Devel
alias g=git
alias lg=lazygit
alias e=$EDITOR
alias sue=sudoedit
alias t='tmux attach 2>/dev/null || tmux'

alias cksh='shellcheck -s sh'
alias fmtsh='shfmt -w -s'

### Gentoo
alias gc='cd ~/gentoo-config'
alias gch='cd ~/gentoo-config/home/zentaro'
alias p=portage
alias manifest='sudo pkgdev manifest'
alias world='cat /var/lib/portage/world'
alias worldmod="sudoedit /var/lib/portage/world"
alias sets='cat /var/lib/portage/world_sets'
alias setsmod="sudoedit /var/lib/portage/world_sets"

## Control
alias bright='brightnessctl set'

## Extra
alias f=fastfetch
alias nvidia-status='cat /sys/bus/pci/devices/0000\:01\:00.0/power/runtime_status'
alias osu-run='nvidia-offload osu &'

### Waydroid
alias wd-stop='sudo -- waydroid -- session stop && sudo -- rc-service -- waydroid stop'
alias wd-start='wd-stop && sudo -- rc-service -- waydroid start && nvidia-offload waydroid -- show-full-ui'

## Eval
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/config.jsonc)"
[[ "$SHLVL" -le 2 && "$WAYLAND_DISPLAY" ]] && fastfetch
