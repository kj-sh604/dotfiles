#!/bin/sh

run () {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run picom -b
run volumeicon
run xfce4-volumed-pulse
run xfce4-clipman
run /usr/lib/geoclue-2.0/demos/agent
run /usr/lib/kdeconnectd
run kdeconnect-indicator
run nm-applet
run system-config-printer-applet
run start-pulseaudio-x11
run /usr/lib/tracker-miner-fs-3
run /usr/lib/tracker-miner-rss-3
run /usr/lib/at-spi-bus-launcher --launch-immediately
run /usr/bin/gnome-keyring-daemon --start --components=pkcs11
run /usr/bin/gnome-keyring-daemon --start --components=secrets
run /usr/bin/gnome-keyring-daemon --start --components=ssh
run xss-lock slock
run dunst
run ~/.config/awesome/xinput-daemon.sh
run ~/.config/awesome/keymapper.sh
run ~/.config/awesome/dpms.sh
run ibus-daemon -drxR
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run wineserver
run /usr/lib/evolution-addressbook-factory
run /usr/lib/evolution-calendar-factory
run /usr/lib/evolution-source-registry
