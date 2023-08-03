if status is-interactive
    # commands to run in interactive sessions can go here
        fish_vi_key_bindings

    # personal aliases
        alias ls="ls --group-directories-first -h -p --color -F"
        alias s="cd ~/.local/bin && ls"
        alias d="disown"
        alias c="cal"
        alias w="curl wttr.in"
        alias x="startx"
        alias t="timedatectl"
        alias p="command yay"
        alias pu="command yay -Syyu --answerclean yes --rebuildall --noconfirm"
        alias yay="echo"
        alias neofetch="alsi"
        alias grep='grep --colour=auto'
        alias egrep='grep -E'
        alias fgrep='grep -F'

    # youtube-dl aliases
        alias yt-mp4="youtube-dl -cif 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
        alias yt-webm="youtube-dl -cif 'bestvideo[ext=webm]+bestaudio[ext=webm]/best[ext=webm]/best'"
        alias yt-m4a="youtube-dl -cif 'bestaudio[ext=m4a]'"

    # pomodoro timer aliases
        alias work="timer 30m && notify-send \
        'Pomodoro' 'Work Timer is up! Take a Break 😊' -i \
        ~/.cache/pomo/pomo-tomato.png -t 30000 -w -A 'Dismiss'\
        & disown; mpv '/home/kylert/.cache/pomo/pomo-sound.mp3'"
        
        alias rest="timer 10m && notify-send \
        'Pomodoro' 'Break is over! Get back to work 😬' -i \
        ~/.cache/pomo/pomo-tomato.png -t 30000 -w -A 'Dismiss'\
        & disown; mpv '/home/kylert/.cache/pomo/pomo-sound.mp3'"

    # experimental rust-uutits substitutions for testing
        alias basenc=uu-basenc
        alias groups=uu-groups
        alias hostname=uu-hostname
        alias join=uu-join
        alias kill=uu-kill
        alias pathchk=uu-pathchk
        alias realpath=uu-realpath
        alias touch=uu-touch

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
