#!/bin/sh

key-mapper-control --command stop-all && key-mapper-control --command autoload && sleep 1 && setxkbmap -option compose:ralt && xmodmap ~/.Xmodmap && xset r rate 300 50 # && setxkbmap -option caps:escape_shifted_capslock
