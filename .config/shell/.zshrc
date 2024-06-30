# source zsh extensions (order is important)
source ~/.config/shell/git-prompt.zsh
source ~/.config/shell/git-prompts/kj_sh604.zsh
source ~/.config/shell/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/shell/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.config/shell/zsh-history-substring-search/zsh-history-substring-search.zsh
# source ~/.config/shell/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ ! -d ~/.local/state/shell ] && mkdir -p ~/.local/state/shell
[ ! -f ~/.local/state/shell/zsh_history ] && touch ~/.local/state/shell/zsh_history

# configure history settings
HISTFILE=~/.local/state/shell/zsh_history
HISTSIZE=9999999
SAVEHIST=9999999

# aliases
    # personal aliases
        alias c="cal"
        alias d="disown"
        alias echo="command echo"
        alias egrep='grep -E'
        alias fgrep='grep -F'
        alias grep='grep --colour=auto'
        alias ls="ls --group-directories-first -h -p --color -F"
        alias neofetch="alsi"
        alias p="paru"
        alias printf="command printf"
        alias pu="paru -Syu --noconfirm"
        alias s="cd ~/.local/bin && ls"
        alias t="timedatectl"
        alias w="curl wttr.in"
        alias x="startx"

    # youtube-dl aliases
        alias yt-mp4="youtube-dl -cif 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
        alias yt-webm="youtube-dl -cif 'bestvideo[ext=webm]+bestaudio[ext=webm]/best[ext=webm]/best'"
        alias yt-m4a="youtube-dl -cif 'bestaudio[ext=m4a]'"

# pfetch stuff 
export PF_INFO="ascii title os kernel uptime pkgs memory"

# initiate the prompt configuration with color support
autoload -Uz colors && colors

# load auto/tab completion and include hidden files
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# opt-in for automatic directory navigation and disallow terminal freeze via ctrl-s 
setopt AUTO_CD NO_FLOW_CONTROL
setopt INTERACTIVE_COMMENTS

# enable vi mode and setup keys for tab completion
bindkey -v
export KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# cursor shape settings for vi modes
function zle-keymap-select() {
    case $KEYMAP in
        vicmd)
            print -n '\e[2 q'
            ;;
        viins|main)
            print -n '\e[6 q'
            ;;
    esac
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins
    print -n "\e[6 q"
}
zle -N zle-line-init
print -n '\e[6 q'

# disable blinking cursor after each command execution
function disable_blinking_cursor() {
    print -n '\e[0 q'
}
precmd_functions+=(disable_blinking_cursor)
disable_blinking_cursor

# less termcap variables (for colored man pages)
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;31m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;33m'

bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
