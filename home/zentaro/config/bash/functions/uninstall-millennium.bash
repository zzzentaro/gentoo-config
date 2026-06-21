uninstall-millennium() {
	sudo rm -rf \
		/usr/lib/millennium \
		/usr/share/millennium \
		"${XDG_CONFIG_HOME:-$HOME/.config}/millennium" \
		"${XDG_DATA_HOME:-$HOME/.local/share}/millennium"
}
