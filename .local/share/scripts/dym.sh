#!/bin/sh

WORD=$(echo "\n" | ~/.local/bin/dmenu-adwaita -b -i -p "Check Spelling: ")

[ -z "$WORD" ] && exit

if [ -n "$1" ]; then
	xdotool type "$WORD"
else
	CORRECTED=$(dym -c $WORD -n 10 | ~/.local/bin/dmenu-adwaita -i -b -l 10 -p "Did you mean?:")
        [ -z "$CORRECTED" ] && exit
 
             if [ -n "$1" ]; then
             	xdotool type "$CORRECTED"
             else
	        echo -n "$CORRECTED" | xclip -selection clipboard
                notify-send "'$CORRECTED' copied to clipboard." &
	     fi

fi


