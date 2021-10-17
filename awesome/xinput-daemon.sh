#!/bin/sh

xinput set-prop pointer:"Logitech USB Trackball" "libinput Natural Scrolling Enabled" 1
xinput set-prop pointer:"Logitech USB Trackball" "libinput Accel Speed" 0.90000
xinput set-prop pointer:"SteelSeries SteelSeries Rival 310 eSports Mouse" "libinput Scrolling Pixel Distance" 30

while true; do state=$(lsusb) && sleep 2 && [ "$state != $(lsusb)" ] && /home/kylert/.config/awesome/xinput.sh; done
