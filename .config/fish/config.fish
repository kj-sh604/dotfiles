if status is-login
    exec bash -c "test -e /etc/profile && source /etc/profile;\
    test -e ~/.zprofile && source ~/.zprofile;\
    exec fish"
end

if status is-interactive
    # commands to run in interactive sessions can go here
        fish_vi_key_bindings

    # personal aliases
        alias c="cal"
        alias d="disown"
        alias echo="command echo"
        alias egrep='grep -E'
        alias fgrep='grep -F'
        alias grep='grep --colour=auto'
        alias ls="ls --group-directories-first -h -p --color -F"
        alias neofetch="alsi"
        alias p="command yay"
        alias printf="command printf"
        alias pu="command yay -Syu --answerclean yes --rebuildall --noconfirm"
        alias s="cd ~/.local/bin && ls"
        alias t="timedatectl"
        alias w="curl wttr.in"
        alias x="startx"
        alias yay="echo"

    # youtube-dl aliases
        alias yt-mp4="youtube-dl -cif 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
        alias yt-webm="youtube-dl -cif 'bestvideo[ext=webm]+bestaudio[ext=webm]/best[ext=webm]/best'"
        alias yt-m4a="youtube-dl -cif 'bestaudio[ext=m4a]'"

    # environment variable declarations
        export PF_INFO="ascii title os kernel uptime pkgs memory"

    # less termcap variables (for colored man pages)
        set -gx LESS_TERMCAP_mb \e'[1;32m'
        set -gx LESS_TERMCAP_md \e'[1;32m'
        set -gx LESS_TERMCAP_me \e'[0m'
        set -gx LESS_TERMCAP_se \e'[0m'
        set -gx LESS_TERMCAP_so \e'[01;31m'
        set -gx LESS_TERMCAP_ue \e'[0m'
        set -gx LESS_TERMCAP_us \e'[1;4;33m'
end
