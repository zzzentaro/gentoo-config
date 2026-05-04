#!/bin/sh
if command -v steam >/dev/null; then
	curl -fsSL 'https://steambrew.app/install.sh' | bash
else
	echo '[info] Steam is not installed, btw'
fi
