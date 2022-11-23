#!/bin/sh

input-remapper-control --command stop-all && input-remapper-control --command autoload && sleep 1 && setxkbmap -option compose:ralt && sleep 1 && xmodmap ~/.Xmodmap && sleep 1 && xset r rate 300 50
