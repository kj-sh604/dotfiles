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
source_if_exists ~/.zprofile

# git prompt
source_if_exists ~/.config/shell/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=1

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

set -o vi

bind -m vi-command '"\C-e": edit-and-execute-command'
bind -m vi-insert  '"\C-e": edit-and-execute-command'

# aliases
command which eza >/dev/null 2>&1 && alias ls="eza"
command which alsi >/dev/null 2>&1 && alias neofetch="alsi"
alias S="cd ~/.local/bin && ls"
alias d="disown"
alias dots="cd ~/.local/share/.dotfiles/"
alias egrep='grep -E'
alias fgrep='grep -F'
alias grep='grep --color=auto'
alias ks="killall screen"
alias la='ls -lah'
alias lgit="lazygit"
alias p="paru"
alias pu="paru -Syu --noconfirm"
alias s="screen"
alias sls="screen -ls"
alias sr="screen -r"
alias t="timedatectl"
alias uncommit="git reset --soft HEAD^"
alias x="startx"
alias yt-best="youtube-dl -cif 'bestvideo+bestaudio/best'"
alias yt-m4a="youtube-dl -cif 'bestaudio[ext=m4a]'"
alias yt-mp4="youtube-dl -cif 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
alias yt-webm="youtube-dl -cif 'bestvideo[ext=webm]+bestaudio[ext=webm]/best[ext=webm]/best'"
