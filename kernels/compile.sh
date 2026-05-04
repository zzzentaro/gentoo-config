#!/bin/sh
set -eu

if [ -f '.config' ]; then
	make oldconfig
else
	echo '[ !! ] Missing config'
	exit 1
fi

printf ":: Start compiling? [y/N] "
read -r _COMPILE
case "$_COMPILE" in
[yY][eE][sS] | [yY])
	echo "[ ok ] Let's compile..."
	;;
*)
	echo "[info] Opening config..."
	make nconfig
	exit 0
	;;
esac
make clean
make cleandocs
make modules_prepare
make --jobs=6 --load-average=12
make modules_install
make install
