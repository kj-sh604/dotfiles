if status is-interactive
    # Commands to run in interactive sessions can go here
    
    alias ls="lsd --group-dirs first -h --icon-theme unicode -L"
    alias qw="cat to-do"
    alias eqw="vim to-do"
    alias sf="mplayer tv:// -tv driver=v4l2:device=/dev/video0:width=1280:height=720:fps=30:outfmt=yuy2"
    export PF_INFO="ascii title os kernel uptime pkgs memory"

    
end
