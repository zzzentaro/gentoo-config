#!/bin/env bash

here="$(cd $(dirname "$BASH_SOURCE[0]") && pwd)"

ln -sf "$here"/bash/profile.bash "$HOME"/.bash_profile
ln -sf "$here"/bash/rc.bash "$HOME"/.bashrc
ln -sf "$here"/bash/logout.bash "$HOME"/.bash_logout
ln -sf "$here"/alacritty "$HOME"/.config/alacritty
ln -sf "$here"/fastfetch "$HOME"/.config/fastfetch
ln -sf "$here"/fuzzel "$HOME"/.config/fuzzel
mkdir -p "$HOME"/Pictures/Wallpaper
ln -sf "$here"/Pictures/Wallpapers/lemuen-panels.png "$HOME"/Pictures/Wallpapers/lemuen-panels.png
