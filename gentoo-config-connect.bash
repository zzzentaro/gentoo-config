#!/bin/env bash

here="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"

# --- --- --- --- --- --- --- --- ---
# > home directory
# --- --- --- --- --- --- --- --- ---
ln -sf "$here"/bash/profile.bash "$HOME"/.bash_profile
ln -sf "$here"/bash/rc.bash "$HOME"/.bashrc
ln -sf "$here"/bash/logout.bash "$HOME"/.bash_logout

# --- --- --- --- --- --- --- --- ---
# > .config
# --- --- --- --- --- --- --- --- ---
for item in alacritty fastfetch fuzzel; do
    rm -rf "$HOME/.config/$item"
    ln -sf "$here/$item" "$HOME/.config/$item"
done

# --- --- --- --- --- --- --- --- ---
# > xdg-user-dir PICTURES
# --- --- --- --- --- --- --- --- ---
mkdir -p "$HOME"/Pictures/Wallpaper
ln -sf "$here"/Pictures/Wallpapers/lemuen-panels.png "$HOME"/Pictures/Wallpapers/lemuen-panels.png
