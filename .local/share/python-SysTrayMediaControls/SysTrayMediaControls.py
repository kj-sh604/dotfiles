import gi
import dbus
import dbus.mainloop.glib
import subprocess

gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')
from gi.repository import Gtk, AppIndicator3

class SysTrayMediaControls:
    def __init__(self):
        self.indicator = AppIndicator3.Indicator.new(
            "media-control-app",
            "audio-x-generic",
            AppIndicator3.IndicatorCategory.APPLICATION_STATUS
        )
        self.indicator.set_status(AppIndicator3.IndicatorStatus.ACTIVE)
        self.indicator.set_menu(self.create_menu())

        # initialize dbus main loop
        dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
        self.bus = dbus.SessionBus()
        self.player = None
        self.find_media_player()

    def create_menu(self):
        menu = Gtk.Menu()

        play_item = Gtk.MenuItem(label="Play/Pause")
        play_item.connect("activate", self.play_pause)
        menu.append(play_item)

        next_item = Gtk.MenuItem(label="Next")
        next_item.connect("activate", self.next_track)
        menu.append(next_item)

        prev_item = Gtk.MenuItem(label="Previous")
        prev_item.connect("activate", self.prev_track)
        menu.append(prev_item)

        quit_item = Gtk.MenuItem(label="Quit")
        quit_item.connect("activate", self.quit)
        menu.append(quit_item)

        menu.show_all()
        return menu

    def find_media_player(self):
        for service in self.bus.list_names():
            if service.startswith('org.mpris.MediaPlayer2.'):
                self.player = self.bus.get_object(service, '/org/mpris/MediaPlayer2')
                self.interface = dbus.Interface(self.player, dbus_interface='org.mpris.MediaPlayer2.Player')
                break

    def play_pause(self, source):
        if self.interface:
            self.interface.PlayPause()

    def next_track(self, source):
        if self.interface:
            self.interface.Next()

    def prev_track(self, source):
        if self.interface:
            self.interface.Previous()

    def quit(self, source):
        Gtk.main_quit()

def main():
    app = SysTrayMediaControls()
    Gtk.main()

if __name__ == "__main__":
    main()
