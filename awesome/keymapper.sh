#!/bin/sh

key-mapper-control --command stop-all && key-mapper-control --command autoload && sleep 1 && setxkbmap -option compose:ralt && setxkbmap -option caps:escape_shifted_capslock && xmodmap ~/.Xmodmap && xset r rate 300 50
