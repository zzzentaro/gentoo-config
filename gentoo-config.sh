#!/bin/sh
set -eu

# Setup
HERE="$(cd -- "$(dirname -- "$0")" && pwd)"
readonly HERE
echo "@ $HERE"

readonly backup_dir="$HERE/tmp"
mkdir -p -- "$backup_dir"

readonly repo_home="$HERE/home/zentaro"

symlink()
{
	echo "mv -- "$2" "$backup_dir/$(basename "$2")-$(date +%F)-$(date +%s)" || true"
	mv -- "$2" "$backup_dir/$(basename "$2")-$(date +%F)-$(date +%s)" || true

	echo "ln -sfn -- "$1" "$2""
	ln -sfn -- "$1" "$2"
}

## Config
echo 'symlink config'
readonly home_config="$HOME/.config" repo_home_config="$repo_home/config"
mkdir -p -- "$home_config"

for config in "$repo_home_config/"*; do
	symlink "$config" "$home_config/$(basename -- "$config")"
done

## Bash is special
echo 'symlink bash'
readonly repo_bash="$repo_home_config/bash" home_bash="$HOME"

symlink "$repo_bash/profile.bash" "$home_bash/.bash_profile"
symlink "$repo_bash/bashrc.bash" "$home_bash/.bashrc"
symlink "$repo_bash/logout.bash" "$home_bash/.bash_logout"
symlink "$repo_bash/functions" "$home_bash/.bashrc.d"

## Local
echo 'symlink local'
readonly repo_home_lib="$repo_home/local/lib" home_lib="$HOME/.local/lib"
mkdir -p -- "$home_lib"
readonly repo_home_bin="$repo_home/local/bin" home_bin="$HOME/.local/bin"
mkdir -p -- "$home_bin"

for bin in "$repo_home_bin/"*; do
	chmod +x "$bin"
	symlink "$bin" "$home_bin/$(basename -- "$bin")"
done

echo 'symlink wal'
readonly repo_wal="$HERE/usr/share/wallpapers" home_wal="$HOME/Pictures/Wallpapers"
mkdir -p -- "$home_wal"

for wal in "$repo_wal/"*; do
	symlink "$wal" "$home_wal/$(basename -- "$wal")"
done

## Root

command -v emerge >/dev/null 2>&1 || exit

echo 'symlink portage'
readonly repo_portage="$HERE/etc/portage" host_portage='/etc/portage'
[ ! -d "$host_portage" ] && sudo mkdir -p -- "$host_portage"

for item in "$repo_portage/"*; do
	symlink "$item" "$host_portage/$(basename -- "$item")"
done
