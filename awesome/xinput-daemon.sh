#!/usr/bin/env bash

xinput set-prop pointer:"Logitech USB Trackball" "libinput Natural Scrolling Enabled" 1
xinput set-prop pointer:"Logitech USB Trackball" "libinput Accel Speed" 0.90000
xinput set-prop pointer:"SteelSeries SteelSeries Rival 310 eSports Mouse" "libinput Scrolling Pixel Distance" 50
xinput set-prop pointer:"SteelSeries SteelSeries Rival 310 eSports Mouse" "libinput Accel Speed" 0.300000
xinput set-prop pointer:"ELECOM ELECOM TrackBall Mouse" "libinput Accel Speed" 0.300000
xinput set-prop pointer:"ELECOM ELECOM TrackBall Mouse" "libinput Scrolling Pixel Distance" 50
xinput set-prop pointer:"Logitech M705" "libinput Accel Speed" 1.000000
xinput set-prop pointer:"Logitech M705" "libinput Scrolling Pixel Distance" 50


while true; do state=$(lsusb) && sleep 2 && [[ $state != $(lsusb) ]] && /home/kylert/.config/awesome/xinput.sh; done
