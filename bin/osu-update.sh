#!/bin/sh
set -u

_OSU_LATEST='https://github.com/ppy/osu/releases/latest/download/osu.AppImage'
_OSU_APPIMAGE="${HOME:?}/.local/bin/osu"
main() {
	rm -f "$_OSU_APPIMAGE"
	wget --continue --tries=3 "$_OSU_LATEST" --output-document "$_OSU_APPIMAGE"
	chmod +x "$_OSU_APPIMAGE"
}
main
