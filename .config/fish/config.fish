if status is-interactive
    # Commands to run in interactive sessions can go here
    
    alias ls="lsd --group-dirs first -h --icon-theme unicode -L"
    alias s="cd ~/.local/share/scripts && lsd --group-dirs first -h --icon-theme unicode -L"
    alias d="disown"
    alias c="cal"
    alias work="timer 30m && notify-send 'Pomodoro' 'Work Timer is up! Take a Break 😊' -i '/home/kylert/.cache/pomo/pomo-tomato.png' -t 30000 -w -A 'Dismiss' & disown; mpv '/home/kylert/.cache/pomo/pomo-sound.mp3'"
    alias rest="timer 10m && notify-send 'Pomodoro' 'Break is over! Get back to work 😬' -i '/home/kylert/.cache/pomo/pomo-tomato.png' -t 30000 -w -A 'Dismiss' & disown; mpv '/home/kylert/.cache/pomo/pomo-sound.mp3'"
    export PF_INFO="ascii title os kernel uptime pkgs memory"

    
end
