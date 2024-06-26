import gi
import subprocess
import os

gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')
from gi.repository import Gtk, AppIndicator3

class playerctl_systray:
    def __init__(self):
        self.indicator = AppIndicator3.Indicator.new(
            "media-control-app",
            "audio-x-generic",
            AppIndicator3.IndicatorCategory.APPLICATION_STATUS
        )
        self.indicator.set_status(AppIndicator3.IndicatorStatus.ACTIVE)
        self.indicator.set_menu(self.create_menu())

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

    def play_pause(self, source):
        self.run_command("playerctl play-pause")

    def next_track(self, source):
        self.run_command("playerctl next")

    def prev_track(self, source):
        self.run_command("playerctl previous")

    def run_command(self, command):
        subprocess.run(command, shell=True)

    def quit(self, source):
        Gtk.main_quit()

def main():
    app = playerctl_systray()
    Gtk.main()

if __name__ == "__main__":
    main()
