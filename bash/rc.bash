[[ $- != *i* ]] && return

EDITOR=${EDITOR:-nano}

alias x='exec bash'
alias xx='exit'
alias hex='sudo'

# ---
# vcs stuff
# ---
alias g='git'
alias lg='lazygit'

# ---
# for dir navigation n file management
# ---
alias e='yazi'
alias cpwl='wl-copy'

alias c='cd'
alias ..='cd ..'
alias ...='cd ../..'

alias ls='eza --group-directories-first --no-permissions --octal-permissions --icons=auto'
alias l='ls -Ahl'

alias mkdir='mkdir -p'
alias md='mkdir'

alias grep='grep --color=auto'
alias gr='grep -i'

alias cp='cp -i'

alias rm='rm -i'
alias rmm='sudo rm -rf'

alias df='df -h'
alias free='free -h'

# image view
iv() {
  chafa $1 2> /dev/null || magick $1 png:- | chafa
}

# ---
# control panel (or what could be)
# ---
alias scr='brightnessctl set'

pps() {
  local option="$1"

  case "$option" in
    1) powerprofilesctl set power-saver ;;
    2) powerprofilesctl set balanced ;;
    3) powerprofilesctl set performance ;;
    *)
      echo "usage: $FUNCNAME <option>"
      echo "option: 1 (power-saver), 2 (balanced), 3 (performance)"
      ;;
  esac
  echo "current: $(powerprofilesctl get)"
  return
}

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

# ---
# gentoo's portage
# ---

alias p='portage'
alias psy='portage sync'
alias p-+='portage rebuild'
alias p++='portage update'
alias p--='portage clean'
alias ps='portage search'
alias pu='portage usedesc'
alias pk='portage kernel'
alias prp='portage repo'
alias p+='portage merge'
alias p-='portage unmerge'
alias pe='portage edit'

alias d-c='sudo dispatch-conf'
alias e-u='sudo etc-update'

alias world='cat /var/lib/portage/world'
alias worldmod="sudo $EDITOR /var/lib/portage/world"
alias sets='cat /var/lib/portage/world_sets'
alias setsmod="sudo $EDITOR /var/lib/portage/world_sets"

# editor
alias n='nano'
alias v='vim'
alias mmk='sudo $EDITOR /etc/portage/make.conf'

alias er="sudo $EDITOR"
qe() {
  local item="$1"
  local target
  case "$item" in
    'r')
      target='.bashrc'
      ;;
    'pro')
      target='.bash_profile'
      ;;
    'out')
      target='.bash_logout'
      ;;
    'er')
      target='.vimrc'
      ;;
    'wm')
      target='.config/sway/config'
      ;;
    'run')
      target='.config/fuzzel/fuzzel.ini'
      ;;
    'bar')
      case "$2" in
        's')
          target='.config/waybar/style.css'
          ;;
        *)
          target='.config/waybar/config.jsonc'
          ;;
      esac
      ;;
    'f')
      case "$2" in
        'l')
          target='.config/fastfetch/logo'
          ;;
        *)
          target='.config/fastfetch/config.jsonc'
          ;;
      esac
      ;;
    't')
      target='.config/alacritty/alacritty.toml'
      ;;
    'e')
      target='.config/yazi/yazi.toml'
      ;;

    *)
      target='.bashrc'
      ;;
  esac
  "$EDITOR" "$HOME/$target"

  return 0
}

# formatter
alias fmtsh='shfmt -w -s -i 2 -ci -sr'

# moods and flavours
alias zidle='scr 5% && pps 1 && swaylock'
alias zpresent='scr 10% && pps 2'
alias zmake='scr 5% && pps 3'

# waydroid
alias wdx='sudo -v && waydroid session stop; sleep 2 && sudo rc-service waydroid stop'
alias wd='wdx && sudo rc-service waydroid start; sleep 2 && waydroid show-full-ui'

# misc
alias ff='fastfetch'
clear -x
[[ $SHLVL -le 2 ]] && fastfetch
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/config.jsonc)"
