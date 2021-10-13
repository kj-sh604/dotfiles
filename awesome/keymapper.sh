#!/bin/sh

key-mapper-control --command stop-all && key-mapper-control --command autoload && sleep 2 && setxkbmap -option compose:ralt && sleep 1 && xmodmap ~/.Xmodmap && sleep 1 && xset r rate 300 50
