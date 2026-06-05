mount-git() {
	_git_partition=/dev/nvme0n1p6
	_git_home="$HOME/git"
	mkdir -p -- "$_git_home"
	sudo mount -- "$_git_partition" "$_git_home"
	sudo chown -R "$USER": "$_git_home"
}
