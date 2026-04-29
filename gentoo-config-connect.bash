#!/usr/bin/env bash

# --- --- --- --- --- --- --- --- ---
# > establish connection
# --- --- --- --- --- --- --- --- ---
HERE="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
sudo chown -R "$USER":root "$HERE"

# --- --- --- --- --- --- --- --- ---
# > home directory
# --- --- --- --- --- --- --- --- ---
ln -sfn "$HERE"/bash/profile.bash "$HOME"/.bash_profile
ln -sfn "$HERE"/bash/rc.bash "$HOME"/.bashrc
ln -sfn "$HERE"/bash/logout.bash "$HOME"/.bash_logout
ln -sfn "$HERE"/vim/rc.vim "$HOME"/.vimrc
ln -sfn "$HERE"/.editorconfig "$HOME"/.editorconfig

rm -rf "$HOME"/db
ln -sfn "$HERE/db" "$HOME"/db

# --- --- --- --- --- --- --- --- ---
# > dotlocal shell
# --- --- --- --- --- --- --- --- ---
mkdir -p "$HOME"/.local/lib
for item in zsl; do
	chmod -x "$HERE/lib/${item}.bash"
	rm -f "$HOME/.local/lib/$item"
	ln -sfn "$HERE/lib/${item}.bash" "$HOME/.local/lib/$item"
done

mkdir -p "$HOME"/.local/bin
for item in gentoo-config portage menu noogetctl; do
	chmod +x "$HERE/bin/${item}.bash"
	rm -f "$HOME/.local/bin/$item"
	ln -sfn "$HERE/bin/${item}.bash" "$HOME/.local/bin/$item"
done

# --- --- --- --- --- --- --- --- ---
# > dotconfig
# --- --- --- --- --- --- --- --- ---
for item in hypr waybar alacritty fastfetch oh-my-posh fuzzel yazi; do
	rm -rf "$HOME/.config/$item"
	ln -sfn "$HERE/$item" "$HOME/.config/$item"
done
mkdir -p "$HOME"/.config/vesktop/settings/
rm -f "$HOME"/.config/vesktop/settings/quickCss.css
ln -sfn "$HERE"/vesktop/settings/quickCss.css "$HOME"/.config/vesktop/settings/quickCss.css

# --- --- --- --- --- --- --- --- ---
# > xdg-user-dir PICTURES
# --- --- --- --- --- --- --- --- ---
mkdir -p "$HOME"/Pictures/Wallpaper
ln -sfn "$HERE"/Pictures/Wallpapers/lemuen-panels.png "$HOME"/Pictures/Wallpapers/lemuen-panels.png

# --- --- --- --- --- --- --- --- ---
# > portage. have you mooed today?
# --- --- --- --- --- -- --- --- ---
command -v emerge >/dev/null || exit
for item in make.conf repos.conf sets; do
	sudo rm -rf /etc/portage/"$item"
	sudo ln -sfn "$HERE/portage/$item" /etc/portage/"$item"
done
