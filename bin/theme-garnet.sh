#!/bin/sh
set -eu
. "$HOME/.local/lib/zxy" || {
	printf " !! zxy is missing\n"
	exit 1
}
_CONFIG="$HOME/.config"

_ALACRITTY_DIR="$_CONFIG/alacritty"
zxy_log 'Alacritty'
ln -sfn "$_ALACRITTY_DIR/theme-garnet.toml" "$_ALACRITTY_DIR/theme.toml"

_FASTFETCH_DIR="$_CONFIG/fastfetch"
zxy_log 'Fastfetch'
ln -sfn "$_FASTFETCH_DIR/config-garnet.jsonc" "$_FASTFETCH_DIR/config.jsonc"

_FUZZEL_DIR="$_CONFIG/fuzzel"
zxy_log 'Fuzzel'
ln -sfn "$_FUZZEL_DIR/theme-garnet.ini" "$_FUZZEL_DIR/theme.ini"

_HYPR_DIR="$_CONFIG/hypr"
zxy_log 'Hyprland'
ln -sfn "$_HYPR_DIR/theme-garnet.lua" "$_HYPR_DIR/theme.lua"

_WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
zxy_log 'Hyprpaper'
ln -sfn "$_WALLPAPER_DIR/Kanaria.jpg" "$_HYPR_DIR/wp"

_OMP_DIR="$_CONFIG/oh-my-posh"
zxy_log 'Oh My Posh'
ln -sfn "$_OMP_DIR/config-garnet.jsonc" "$_OMP_DIR/config.jsonc"

_WAYBAR_DIR="$_CONFIG/waybar"
zxy_log 'Waybar'
ln -sfn "$_WAYBAR_DIR/theme-garnet.css" "$_WAYBAR_DIR/theme.css"
