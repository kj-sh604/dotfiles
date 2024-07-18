# note: this file needs to be sourced in /etc/bash.bashrc

# personal QOL functions
source_if_exists() {
    [ -f "$1" ] && source "$1"
}

ensure_directory_and_file() {
    [ ! -d "$1" ] && mkdir -p "$1"
    [ ! -f "$2" ] && touch "$2"
}

# source personal posix functions
source_if_exists ~/.config/shell/posix-functions/create_POSIX_dotenv.sh
source_if_exists ~/.config/shell/posix-functions/POSIX_open.sh

# git prompt
source_if_exists ~/.config/shell/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

if [[ $- != *i* ]] ; then
	return
fi

shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histappend

case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|interix)
		PS1='\[\033]0;\u@\h:\w\007\]'
		;;
	screen*)
		PS1='\[\033k\u@\h:\w\033\\\]'
		;;
	*)
		unset PS1
		;;
esac

use_color=false
if type -P dircolors >/dev/null ; then
	LS_COLORS=
	if [[ -f ~/.dir_colors ]] ; then
		used_default_dircolors="no"
		eval "$(dircolors -b ~/.dir_colors)"
	elif [[ -f /etc/DIR_COLORS ]] ; then
		used_default_dircolors="maybe"
		eval "$(dircolors -b /etc/DIR_COLORS)"
	else
		used_default_dircolors="yes"
		eval "$(dircolors -b)"
	fi
	if [[ -n ${LS_COLORS:+set} ]] ; then
		use_color=true
	fi
	unset used_default_dircolors
else
	case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|screen|cons25|*color) use_color=true;;
	esac
fi

if ${use_color} ; then
	if [[ ${EUID} == 0 ]] ; then
		PS1+='\[\033[01;31m\]\h\[\033[01;34m\] \w \$_\[\033[00m\]$(__git_ps1) '
	else
		PS1+='\[\033[01;34m\]\w \$_\[\033[00m\]$(__git_ps1) '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		PS1+='\u@\h \W \$ '
	else
		PS1+='\u@\h \w \$ '
	fi
fi

for sh in /etc/bash/bashrc.d/* ; do
	[[ -r ${sh} ]] && source "${sh}"
done

unset use_color sh

export HISTFILE="$XDG_STATE_HOME"/shell/history
