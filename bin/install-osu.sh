#!/bin/sh
set -u

_OSU_LATEST='https://github.com/ppy/osu/releases/latest/download/osu.AppImage'
_OSU_PATH="${HOME:?}/.local/bin/osu"

rm -f "$_OSU_PATH"
wget --continue --tries=3 "$_OSU_LATEST" --output-document "$_OSU_PATH"
chmod +x "$_OSU_PATH"
