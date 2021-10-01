#!/usr/bin/env bash

key-mapper-control --command stop-all && key-mapper-control --command autoload && sleep 2 && setxkbmap -option compose:ralt && sleep 1 && xmodmap ~/.Xmodmap