#!/bin/sh

run () {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

#run picom --experimental-backends
run picom -b
run nitrogen --restore
run volumeicon
# run lxsession
run xfce4-volumed-pulse
run /usr/lib/gsd-datetime
# run /usr/lib/baloo_file
run xfce4-clipman
# run emojione-picker
# run emote
run /usr/lib/geoclue-2.0/demos/agent
run /usr/lib/kdeconnectd
run kdeconnect-indicator
run nm-applet
run system-config-printer-applet
run start-pulseaudio-x11
# run /bin/snap userd --autostart
run /usr/lib/tracker-miner-fs-3
run /usr/lib/tracker-miner-rss-3
# run /usr/lib/xapps/sn-watcher/xapp-sn-watcher
run /usr/lib/at-spi-bus-launcher --launch-immediately
run /usr/lib/gsd-power
run /usr/bin/gnome-keyring-daemon --start --components=pkcs11
run /usr/bin/gnome-keyring-daemon --start --components=secrets
run /usr/bin/gnome-keyring-daemon --start --components=ssh
run xfce4-power-manager
run dunst
run ~/.config/awesome/xinput-daemon.sh
run ibus-daemon -drxR
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run wineserver
run ~/.config/awesome/keymapper.sh
