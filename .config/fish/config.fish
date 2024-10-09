if status is-login
    exec bash -c "test -e /etc/profile && source /etc/profile;\
    test -e ~/.zprofile && source ~/.zprofile;\
    exec fish"
end

if status is-interactive
    # commands to run in interactive sessions can go here
        fish_vi_key_bindings

    # abbreviations
        abbr -a S "cd ~/.local/bin && ls"
        abbr -a c "cal"
        abbr -a d "disown"
        abbr -a dots "cd ~/.local/share/.dotfiles/"
        abbr -a ks "killall screen"
        abbr -a p "paru"
        abbr -a pu "paru -Syu --noconfirm"
        abbr -a s "screen"
        abbr -a sls "screen -ls"
        abbr -a sr "screen -r"
        abbr -a t "timedatectl"
        abbr -a w "curl wttr.in"
        abbr -a x "startx"
        abbr -a yt-best "youtube-dl -cif 'bestvideo+bestaudio/best'"
        abbr -a yt-m4a "youtube-dl -cif 'bestaudio[ext=m4a]'"
        abbr -a yt-mp4 "youtube-dl -cif 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
        abbr -a yt-mpv "mpv --ytdl-format="
        abbr -a yt-webm "youtube-dl -cif 'bestvideo[ext=webm]+bestaudio[ext=webm]/best[ext=webm]/best'"
    # aliases
        alias egrep='grep -E'
        alias fgrep='grep -F'
        alias grep='grep --colour=auto'
        alias ls="ls --group-directories-first -h -p --color -F"
        alias neofetch="alsi"
        if which bat >/dev/null 2>&1
            alias cat="bat -p"
        end

    # less termcap variables (for colored man pages)
        set -gx LESS_TERMCAP_mb \e'[1;32m'
        set -gx LESS_TERMCAP_md \e'[1;32m'
        set -gx LESS_TERMCAP_me \e'[0m'
        set -gx LESS_TERMCAP_se \e'[0m'
        set -gx LESS_TERMCAP_so \e'[01;31m'
        set -gx LESS_TERMCAP_ue \e'[0m'
        set -gx LESS_TERMCAP_us \e'[1;4;33m'
end
