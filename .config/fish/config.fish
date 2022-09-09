if status is-interactive
    # Commands to run in interactive sessions can go here
    

    # Personal Aliases
        alias s="cd ~/.local/share/scripts && lsd --group-dirs first -h --icon-theme unicode -L"
        alias d="disown"
        alias c="cal"

    # Pomodoro Timer Aliases | Thanks to @bashbunni and @caarlos0
        alias work="timer 30m && notify-send \
        'Pomodoro' 'Work Timer is up! Take a Break 😊' -i \
        '/home/kylert/.cache/pomo/pomo-tomato.png' -t 30000 -w -A 'Dismiss'\
        & disown; mpv '/home/kylert/.cache/pomo/pomo-sound.mp3'"
        
        alias rest="timer 10m && notify-send \
        'Pomodoro' 'Break is over! Get back to work 😬' -i \
        '/home/kylert/.cache/pomo/pomo-tomato.png' -t 30000 -w -A 'Dismiss'\
        & disown; mpv '/home/kylert/.cache/pomo/pomo-sound.mp3'"

    # Command Substitutions | I'm trying out the Rust Coreutils Re-write via the coreutils-hybrid package
        alias echo="uu-echo"
        alias ls="lsd --group-dirs first -h --icon-theme unicode -L"
        alias pwd="uu-pwd"
        alias groups=uu-groups
        alias kill=uu-kill

        # Plan9 Utils Command Substitutions
        alias sort="9 sort"

    # Environment Variable Declarations
        export PF_INFO="ascii title os kernel uptime pkgs memory"

    
end
