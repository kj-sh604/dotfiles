#!/usr/bin/env bash

key-mapper-control --command stop-all && key-mapper-control --command autoload
sleep 4 && xmodmap ~/.Xmodmap &
