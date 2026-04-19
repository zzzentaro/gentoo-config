#!/usr/bin/env bash
source "${HOME}/.local/lib/zsl" || {
  echo "[!!] zsl is missing"
  exit 1
}

noogetctl-conserve() {
  target='/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'

  if [[ ! -f $target ]]; then
    zsl-error "Conservation mode path not found. Is ideapad_acpi module loaded?"
    exit 1
  fi

  current_status=$(cat "$target")
  if [[ $current_status -eq 0 ]]; then
    echo 1 | sudo tee "$target" >/dev/null
    zsl-success "Battery conservation mode is now ENABLED! It will charge to around 80%!!"
  else
    echo 0 | sudo tee "$target" >/dev/null
    zsl-success "Battery conservation mode is now DISABLED! It will charge to full capacity!!"
  fi
}

noogetctl-mode() {
  case "$1" in
  'night')
    pactl set-source-mute @DEFAULT_SOURCE@ 1
    pactl set-sink-mute @DEFAULT_SINK@ 1
    brightnessctl set 5%
    powerprofilesctl set performance
    ;;
  'day')
    pactl set-source-mute @DEFAULT_SOURCE@ 0
    pactl set-sink-mute @DEFAULT_SINK@ 0
    pactl set-source-volume @DEFAULT_SOURCE@ 50%
    pactl set-sink-volume @DEFAULT_SINK@ 50%
    brightnessctl set 10%
    powerprofilesctl set balanced
    ;;
  'morning')
    pactl set-source-mute @DEFAULT_SOURCE@ 0
    pactl set-sink-mute @DEFAULT_SINK@ 0
    pactl set-source-volume @DEFAULT_SOURCE@ 50%
    pactl set-sink-volume @DEFAULT_SINK@ 50%
    brightnessctl set 20%
    powerprofilesctl set power-saver
    ;;
  *) zsl-error "no mode chosen" ;;
  esac
}

if declare -f "noogetctl-$1" >/dev/null; then
  "noogetctl-$1" "$@"
else
  zsl-error
fi
