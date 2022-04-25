if status is-interactive
    # Commands to run in interactive sessions can go here
    
    alias ls="lsd --group-dirs first -h --icon-theme unicode -L"
    alias s="cd ~/.local/share/scripts && lsd --group-dirs first -h --icon-theme unicode -L"
    alias d="disown"
    export PF_INFO="ascii title os kernel uptime pkgs memory"

    
end
