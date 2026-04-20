#!/bin/env bash

# --- --- --- --- --- --- --- --- ---
# > establish connection
# --- --- --- --- --- --- --- --- ---
here="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
sudo chown -R "$USER":root "$here"

# --- --- --- --- --- --- --- --- ---
# > home directory
# --- --- --- --- --- --- --- --- ---
ln -sf "$here"/bash/profile.bash "$HOME"/.bash_profile
ln -sf "$here"/bash/rc.bash "$HOME"/.bashrc
ln -sf "$here"/bash/logout.bash "$HOME"/.bash_logout
ln -sf "$here"/vim/rc.vim "$HOME"/.vimrc

# --- --- --- --- --- --- --- --- ---
# > .local scripts
# --- --- --- --- --- --- --- --- ---
mkdir -p "$HOME"/.local/lib
for item in zsl; do
	chmod -x "$here/lib/${item}.bash"
	rm -f "$HOME/.local/lib/$item"
	ln -sf "$here/lib/${item}.bash" "$HOME/.local/lib/$item"
done

mkdir -p "$HOME"/.local/bin
for item in gentoo-config portage menu noogetctl; do
	chmod +x "$here/bin/${item}.bash"
	rm -f "$HOME/.local/bin/$item"
	ln -sf "$here/bin/${item}.bash" "$HOME/.local/bin/$item"
done

# --- --- --- --- --- --- --- --- ---
# > .config
# --- --- --- --- --- --- --- --- ---
for item in sway swaylock waybar alacritty fastfetch oh-my-posh fuzzel yazi; do
	rm -rf "$HOME/.config/$item"
	ln -sf "$here/$item" "$HOME/.config/$item"
done
mkdir -p "$HOME"/.config/vesktop/settings
rm -f "$HOME"/.config/vesktop/settings/quickCss.css
ln -sf "$here"/vesktop/settings/quickCss.css "$HOME"/.config/vesktop/settings/quickCss.css

# --- --- --- --- --- --- --- --- ---
# > xdg-user-dir PICTURES
# --- --- --- --- --- --- --- --- ---
mkdir -p "$HOME"/Pictures/Wallpaper
ln -sf "$here"/Pictures/Wallpapers/lemuen-panels.png "$HOME"/Pictures/Wallpapers/lemuen-panels.png

# --- --- --- --- --- --- --- --- ---
# > kernel config
# --- --- --- --- --- --- --- --- ---
for item in 6.19.12-zen; do
	sudo rm -f "/usr/src/linux-${item}/.config"
	sudo ln -sf "$here/linux-$item/config" /usr/src/linux-"$item"/.config
done

# --- --- --- --- --- --- --- --- ---
# > portage. have you mooed today?
# --- --- --- --- --- -- --- --- ---
command -v emerge >/dev/null || exit
for item in make.conf repos.conf sets; do
	sudo rm -rf /etc/portage/"$item"
	sudo ln -sf "$here/portage/$item" /etc/portage/"$item"
done
