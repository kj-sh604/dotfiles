#!/bin/sh

# Function to apply the desired settings
apply_settings() {
	sleep 2
	xinput set-prop pointer:"Logitech USB Trackball" "libinput Natural Scrolling Enabled" 1
	xinput set-prop pointer:"Logitech USB Trackball" "libinput Accel Speed" 1.000000
	xinput set-prop pointer:"SteelSeries SteelSeries Rival 310 eSports Mouse" "libinput Accel Speed" 0.300000
	xinput set-prop pointer:"ELECOM ELECOM TrackBall Mouse" "libinput Accel Speed" 0.300000
	xinput set-prop pointer:"Logitech M705" "libinput Accel Speed" 1.000000
}

# Initial application of settings
apply_settings

# Continuously monitor for changes in USB devices and reapply settings if any change is detected
while true; do
	# Get the current state of USB devices
	state=$(lsusb)

	# Wait for 2 seconds
	sleep 2

	# Compare the current state with the new state of USB devices
	# If any change is detected, reapply the settings
	if [ "$state" != "$(lsusb)" ]; then
		apply_settings
	fi
done
