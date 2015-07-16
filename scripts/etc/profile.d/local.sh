if [ "$(id -u)" = "0" ]
then
	export PATH="$PATH:/usr/sbin:/sbin"
	export VISUAL=vim
	export EDITOR=vim
	export PS1='\u@\h[\w]\$ '
	export MAKEFLAGS=${MAKEFLAGS:--j4}
fi
