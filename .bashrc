[[ $- != *i* ]] && return

clear -x
[[ $SHLVL -le 2 ]] && figlet -f slant cool ass text && fastfetch

alias x='exec bash'
alias xx='exit'
alias xxxxx='systemctl reboot'
alias xxxxxx='systemctl poweroff'

alias l='ls -lh'
alias la='ls -la'
alias mkdir='mkdir -p'
alias md='mkdir'
alias ..='cd ..'
alias ...='cd ../..'
alias cp='cp -i'
alias rm='rm -i'
alias rmm='rm -rf'
alias grep='grep --color=auto'
alias df='df -h'
alias free='free -h'
alias icat='kitten icat'

alias cfg='git --git-dir=$HOME/.cfg --work-tree=$HOME'

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

alias ctl='sudo systemctl'
alias scr='brightnessctl set'
alias ppd='powerprofilesctl'
alias ppd1='powerprofilesctl set power-saver'
alias ppd2='powerprofilesctl set balanced'
alias ppd3='powerprofilesctl set performance'

alias vol='pactl get-sink-volume @DEFAULT_SINK@ && pactl get-source-volume @DEFAULT_SOURCE@'
alias volo='pactl set-sink-volume @DEFAULT_SINK@'
alias volox='pactl set-sink-mute @DEFAULT_SINK@ toggle && pactl get-sink-mute @DEFAULT_SINK@'
alias voli='pactl set-source-volume @DEFAULT_SOURCE@'
alias volix='pactl set-source-mute @DEFAULT_SOURCE@ toggle && pactl get-source-mute @DEFAULT_SOURCE@'

alias nnn='nnn -adEHi'
alias n='nnn'

alias makeme="sudo make && sudo make modules_install && sudo make install"
alias ems='emerge --search'
alias emd='emerge --searchdesc'
alias em='sudo emerge --ask --verbose'
alias emx='sudo emerge --sync'
alias emxx='sudo emerge --deep --unmerge --verbose'
alias emc='sudo emerge --deep --depclean'
alias emu='sudo emerge --deep --newuse --update @world'
alias emxu='emx && sudo -v && emu'
alias emxuc='emxu && sudo -v && emc'
alias portageisfuckingbrokenagain='sudo emerge-webrsync --verbose && sudo -v && sudo emaint sync --allrepos --verbose'
alias es='sudo eselect'
alias pkgls='cat /var/lib/portage/world'
alias repols='eselect repository list -i'

alias oh-my-posh='~/.local/bin/oh-my-posh'
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/config.jsonc)"
