#!/bin/sh

input-remapper-control --command stop-all &&\
input-remapper-control --command autoload &&\
sleep 1
if [ -f ~/.Xmodmap ]; then xmodmap ~/.Xmodmap; fi
