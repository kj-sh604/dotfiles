# personal QOL functions
source_if_exists() {
    [ -f "$1" ] && source "$1"
}

ensure_directory_and_file() {
    [ ! -d "$1" ] && mkdir -p "$1"
    [ ! -f "$2" ] && touch "$2"
}

setopt prompt_subst
source_if_exists ~/.config/shell/git-prompt.zsh
source_if_exists ~/.config/shell/git-prompts/kj_sh604-with-attempt-at-fish-style-pwd.zsh
source_if_exists ~/.config/shell/zsh-autosuggestions/zsh-autosuggestions.zsh
source_if_exists ~/.config/shell/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source_if_exists ~/.config/shell/zsh-history-substring-search/zsh-history-substring-search.zsh
source_if_exists ~/.config/shell/zsh-abbr/zsh-job-queue/zsh-job-queue.zsh
source_if_exists ~/.config/shell/zsh-abbr/zsh-abbr.zsh

# source personal posix functions
source_if_exists ~/.config/shell/posix-functions/create_POSIX_dotenv.sh
source_if_exists ~/.config/shell/posix-functions/POSIX_open.sh

ensure_directory_and_file ~/.local/state/shell ~/.local/state/shell/zsh_history

# configure history settings
HISTFILE=~/.local/state/shell/zsh_history
HISTSIZE=9999999
SAVEHIST=9999999

# aliases
    # conditionally alias alternative applications/flags if available
    command which eza >/dev/null 2>&1 && alias ls="eza"
    command which alsi >/dev/null 2>&1 && alias neofetch="alsi"
    command grep --color=auto --version >/dev/null 2>&1 && alias grep='grep --color=auto'

    # personal abbreviations
        abbr -S --quiet S="cd ~/.local/bin && ls"
        abbr -S --quiet c="cal"
        abbr -S --quiet d="disown"
        abbr -S --quiet dots="cd ~/.local/share/.dotfiles/"
        abbr -S --quiet ks="killall screen"
        abbr -S --quiet la='ls -lah'
        abbr -S --quiet lgit="lazygit"
        abbr -S --quiet p="paru"
        abbr -S --quiet pu="paru -Syu --noconfirm"
        abbr -S --quiet s="screen"
        abbr -S --quiet sls="screen -ls"
        abbr -S --quiet sr="screen -r"
        abbr -S --quiet t="timedatectl"
        abbr -S --quiet uncommit="git reset --soft HEAD^"
        abbr -S --quiet x="startx"
        abbr -S --quiet yt-best="youtube-dl -cif 'bestvideo+bestaudio/best'"
        abbr -S --quiet yt-m4a="youtube-dl -cif 'bestaudio[ext=m4a]'"
        abbr -S --quiet yt-mp4="youtube-dl -cif 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
        abbr -S --quiet yt-mpv="mpv --ytdl-format= '' & disown"
        abbr -S --quiet yt-webm="youtube-dl -cif 'bestvideo[ext=webm]+bestaudio[ext=webm]/best[ext=webm]/best'"

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

# edit line in vim with ctrl-x ctrl-e or ctrl-x e
autoload edit-command-line; zle -N edit-command-line
bindkey '^x^e' edit-command-line
bindkey '^xe' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^x^e' edit-command-line
bindkey -M vicmd '^xe' edit-command-line
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
