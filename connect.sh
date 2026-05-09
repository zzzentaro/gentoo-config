#!/bin/sh
# This script is for personal use and destructive
# Back-up your stuff <3
set -eu

if [ "$(id -u)" -eq 0 ]; then
	echo "[ !! ] Do not run as root"
	exit 1
fi
if [ -z "$HOME" ]; then
	echo '[ !! ] HOME not found'
	exit 1
fi

_HERE="$(cd "$(dirname "$0")" && pwd)"
readonly _HERE
sudo chown -R "$USER":"$USER" "$_HERE"

# Home directory item
ln -sfn "$_HERE"/bash/profile.bash "$HOME"/.bash_profile
ln -sfn "$_HERE"/bash/rc.bash "$HOME"/.bashrc
ln -sfn "$_HERE"/bash/logout.bash "$HOME"/.bash_logout
ln -sfn "$_HERE"/vim/rc.vim "$HOME"/.vimrc
ln -sfn "$_HERE"/.editorconfig "$HOME"/.editorconfig

# Local directory program
readonly _LOCAL_DIR="$HOME/.local"
readonly _LIB_DIR="$_LOCAL_DIR/lib"
readonly _STORE_LIB_DIR="$_HERE/lib"
readonly _BIN_DIR="$_LOCAL_DIR/bin"
readonly _STORE_BIN_DIR="$_HERE/bin"

mkdir -p "$_LIB_DIR"
for item in zsl; do
	rm -f "$_LIB_DIR/$item"
	chmod -x "$_STORE_LIB_DIR/$item.sh"
	ln -sfn "$_STORE_LIB_DIR/$item.sh" "$_LIB_DIR/$item"
done

mkdir -p "$_BIN_DIR"
for item in boot-chore nvidia-offload portage portage-sets-refresh rc-user menu steambrew; do
	rm -f "$_BIN_DIR/$item"
	chmod +x "$_STORE_BIN_DIR/$item.sh"
	ln -sfn "$_STORE_BIN_DIR/$item.sh" "$HOME/.local/bin/$item"
done

# Config directory (dotfiles)
readonly _CONFIG_DIR="$HOME/.config"
for item in hypr alacritty waybar mako fuzzel nvim fastfetch oh-my-posh; do
	rm -rf "${_CONFIG_DIR:?}/$item"
	ln -sfn "$_HERE/$item" "$_CONFIG_DIR/$item"
done
mkdir -p "$_CONFIG_DIR"/vesktop/settings/
ln -sfn "$_HERE"/vesktop/settings/quickCss.css "$_CONFIG_DIR"/vesktop/settings/quickCss.css

# Wallpaper
mkdir -p "$HOME"/Pictures/Wallpapers
ln -sfn "$_HERE"/Pictures/Wallpapers/lemuen-panels.png "$HOME"/Pictures/Wallpapers/lemuen-panels.png

# Portage, The Heart of Gentoo. Have you mooed today?
readonly _PORTAGE_DIR="/etc/portage"
sudo chown -R root:root "$_PORTAGE_DIR"
readonly _STORE_PORTAGE_DIR="$_HERE/portage"
sudo chown -R root:root "$_STORE_PORTAGE_DIR"
command -v emerge >/dev/null || exit
for item in make.conf repos.conf sets; do
	sudo rm -rf "${_PORTAGE_DIR:?}/$item"
	sudo ln -sfn "$_STORE_PORTAGE_DIR/$item" "$_PORTAGE_DIR/$item"
done
