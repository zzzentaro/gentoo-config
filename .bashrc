[[ $- != *i* ]] && return

clear -x
[[ $SHLVL -eq 2 ]] && figlet -f slant $USER && fastfetch

alias x='exec bash'
alias xx='exit'
alias reboot='systemctl reboot'
alias poweroff='systemctl poweroff'

# for navigation n files
alias l='ls -lhA'
alias la='ls -lha'

alias grep='grep --color=auto'
alias gp='grep'

alias ..='cd ..'
alias ...='cd ../..'
alias mkdir='mkdir -p'
alias md='mkdir'

alias cp='cp -i'

alias rm='rm -i'
alias rmm='rm -rf'

alias df='df -h'
alias free='free -h'

alias icat='kitten icat'

alias cfg='git --git-dir=$HOME/.cfg --work-tree=$HOME'

# control panel (or what could be)
alias ctl='sudo systemctl'
alias scr='brightnessctl set'
alias ppd='powerprofilesctl'
alias ppd1='powerprofilesctl set power-saver && powerprofilesctl get'
alias ppd2='powerprofilesctl set balanced && powerprofilesctl get'
alias ppd3='powerprofilesctl set performance && powerprofilesctl get'

alias vol='pactl get-sink-volume @DEFAULT_SINK@ && pactl get-source-volume @DEFAULT_SOURCE@'
alias volo='pactl set-sink-volume @DEFAULT_SINK@'
alias volox='pactl set-sink-mute @DEFAULT_SINK@ toggle && pactl get-sink-mute @DEFAULT_SINK@'
alias voli='pactl set-source-volume @DEFAULT_SOURCE@'
alias volix='pactl set-source-mute @DEFAULT_SOURCE@ toggle && pactl get-source-mute @DEFAULT_SOURCE@'

alias nnn='nnn -adEHi'
alias n='nnn'

# gentoo's portage
alias makeme="sudo make && sudo make modules_install && sudo make install"

alias etune='sudo emerge-webrsync && sudo -v && sudo emaint all --allrepos'
alias esync='sudo emerge --sync'
alias eup='sudo emerge --ask --deep --newuse --update --with-bdeps=y'
alias esyup='esync && sudo -v && eup'

alias elook='emerge --search'
alias efind='emerge --searchdesc'

alias e+='sudo emerge --ask --verbose'
alias e-='sudo emerge --ask --deep --unmerge --verbose'
alias eclean='sudo emerge --deep --depclean --verbose'

alias es='sudo eselect'
alias lsrepo='eselect repository list -i'
alias lspkg='cat /var/lib/portage/world'

# editor
alias m='micro'
alias msr='micro ~/.bashrc'
alias mmk='sudo micro /etc/portage/make.conf'
alias msp='micro ~/.bash_profile'
alias mwm='micro ~/.config/sway/config'
alias mal='micro ~/.config/fuzzel/fuzzel.ini'
alias mbarc='micro ~/.config/waybar/config.jsonc'
alias mbars='micro ~/.config/waybar/style.css'
alias mff='micro ~/.config/fastfetch/config.jsonc'
alias mte='micro ~/.config/kitty/kitty.conf'

alias fmtsh='shfmt -w -s -i 2 -ci -sr'

# moods and flavours
alias zidle='scr 5% && ppd1 && swaylock'
alias zpresent='scr 10% && ppd2'
alias zmake='scr 5% && ppd3'

alias ff='fastfetch'

alias oh-my-posh='~/.local/bin/oh-my-posh'
alias omp='oh-my-posh'
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/config.jsonc)"
