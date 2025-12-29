if status is-login
    exec bash -c 'for f in /etc/profile ~/.zprofile ~/.profile; do [ -e "$f" ] && source "$f"; done; exec fish'
end

if status is-interactive
    # aliases
        if command grep --color=auto --version >/dev/null 2>&1
            alias grep='grep --color=auto'
        end
        if which eza >/dev/null 2>&1
            alias ls="eza"
        end
        if which alsi >/dev/null 2>&1
            alias neofetch="alsi"
        end
    # abbreviations
        abbr -a S "cd ~/.local/bin && ls"
        abbr -a c "cal"
        abbr -a d "disown"
        abbr -a dots "cd ~/.local/share/.dotfiles/"
        abbr -a ks "killall screen"
        abbr -a lgit 'lazygit'
        abbr -a p "paru"
        abbr -a pu "paru -Syu --noconfirm"
        abbr -a s "screen"
        abbr -a sls "screen -ls"
        abbr -a sr "screen -r"
        abbr -a t "timedatectl"
        abbr -a uncommit 'git reset --soft HEAD^'
        abbr -a x "startx"
        abbr -a yt-best "youtube-dl -cif 'bestvideo+bestaudio/best'"
        abbr -a yt-m4a "youtube-dl -cif 'bestaudio[ext=m4a]'"
        abbr -a yt-mp4 "youtube-dl -cif 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
        abbr -a yt-mpv "mpv --ytdl-format="
        abbr -a yt-webm "youtube-dl -cif 'bestvideo[ext=webm]+bestaudio[ext=webm]/best[ext=webm]/best'"

    # less termcap variables (for colored man pages)
        set -gx LESS_TERMCAP_mb \e'[1;32m'
        set -gx LESS_TERMCAP_md \e'[1;32m'
        set -gx LESS_TERMCAP_me \e'[0m'
        set -gx LESS_TERMCAP_se \e'[0m'
        set -gx LESS_TERMCAP_so \e'[01;31m'
        set -gx LESS_TERMCAP_ue \e'[0m'
        set -gx LESS_TERMCAP_us \e'[1;4;33m'
end
