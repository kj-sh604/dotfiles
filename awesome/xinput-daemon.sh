#!/bin/sh

xinput set-prop pointer:"Logitech USB Trackball" "libinput Natural Scrolling Enabled" 1
xinput set-prop pointer:"Logitech USB Trackball" "libinput Accel Speed" 0.90000

while true; do state=$(lsusb) && sleep 2 && [ "$state != $(lsusb)" ] && /home/kylert/.config/awesome/xinput.sh; done
