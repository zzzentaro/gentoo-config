#!/usr/bin/env bash
FN='gentoo-config'
source "$HOME"/.local/lib/zsl || {
	echo "[!!] zsl is missing"
	exit 1
}
zsl-require-not-root
zsl-require-command git
zsl-require-home

[[ -d "$HOME"/gentoo-config ]] || git clone ssh://git@codeberg.org/zentaro/gentoo-config.git "$HOME"/gentoo-config
cd "$HOME"/gentoo-config/
ls -Ahl
command -v lazygit >/dev/null && lazygit
