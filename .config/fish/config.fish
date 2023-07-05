if status is-interactive
    # Commands to run in interactive sessions can go here
        fish_vi_key_bindings

    # Personal Aliases
        alias s="cd ~/.local/share/scripts && ls --group-directories-first -h -p --color -F"
        alias ls="ls --group-directories-first -h -p --color -F"
        alias d="disown"
        alias c="cal"
        alias w="curl wttr.in"
        alias x="startx"
        alias t="timedatectl"
        alias p="command yay"
        alias pu="command yay -Syyu --answerclean yes --rebuildall --noconfirm"
        alias yay="echo"
        alias neofetch="alsi"

    # youtube-dl aliases
        alias yt-mp4="youtube-dl -cif 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
        alias yt-webm="youtube-dl -cif 'bestvideo[ext=webm]+bestaudio[ext=webm]/best[ext=webm]/best'"
        alias yt-m4a="youtube-dl -cif 'bestaudio[ext=m4a]'"

    # Pomodoro Timer Aliases
        alias work="timer 30m && notify-send \
        'Pomodoro' 'Work Timer is up! Take a Break 😊' -i \
        ~/.cache/pomo/pomo-tomato.png -t 30000 -w -A 'Dismiss'\
        & disown; mpv '/home/kylert/.cache/pomo/pomo-sound.mp3'"
        
        alias rest="timer 10m && notify-send \
        'Pomodoro' 'Break is over! Get back to work 😬' -i \
        ~/.cache/pomo/pomo-tomato.png -t 30000 -w -A 'Dismiss'\
        & disown; mpv '/home/kylert/.cache/pomo/pomo-sound.mp3'"

    # Environment Variable Declarations
        export PF_INFO="ascii title os kernel uptime pkgs memory"

    # LESS TERMCAP Variables (for colored man pages)
        set -gx LESS_TERMCAP_mb \e'[1;32m'
        set -gx LESS_TERMCAP_md \e'[1;32m'
        set -gx LESS_TERMCAP_me \e'[0m'
        set -gx LESS_TERMCAP_se \e'[0m'
        set -gx LESS_TERMCAP_so \e'[01;31m'
        set -gx LESS_TERMCAP_ue \e'[0m'
        set -gx LESS_TERMCAP_us \e'[1;4;33m'
end
