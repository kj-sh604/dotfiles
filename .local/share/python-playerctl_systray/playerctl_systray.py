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

        play_item = Gtk.MenuItem(label="play-pause")
        play_item.connect("activate", self.play_pause)
        menu.append(play_item)

        next_item = Gtk.MenuItem(label="next")
        next_item.connect("activate", self.next_track)
        menu.append(next_item)

        prev_item = Gtk.MenuItem(label="previous")
        prev_item.connect("activate", self.prev_track)
        menu.append(prev_item)

        stop_item = Gtk.MenuItem(label="stop")
        stop_item.connect("activate", self.stop_track)
        menu.append(stop_item)

        quit_item = Gtk.MenuItem(label="quit")
        quit_item.connect("activate", self.quit)
        menu.append(quit_item)

        menu.append(Gtk.SeparatorMenuItem())  # separator before -a submenu

        a_submenu = Gtk.Menu()

        a_play_item = Gtk.MenuItem(label="play-pause")
        a_play_item.connect("activate", self.a_play_pause)
        a_submenu.append(a_play_item)

        a_next_item = Gtk.MenuItem(label="next")
        a_next_item.connect("activate", self.a_next_track)
        a_submenu.append(a_next_item)

        a_prev_item = Gtk.MenuItem(label="previous")
        a_prev_item.connect("activate", self.a_prev_track)
        a_submenu.append(a_prev_item)

        a_stop_item = Gtk.MenuItem(label="stop")
        a_stop_item.connect("activate", self.a_stop)
        a_submenu.append(a_stop_item)

        a_menu_item = Gtk.MenuItem(label="-a")
        a_menu_item.set_submenu(a_submenu)
        menu.append(a_menu_item)

        menu.show_all()
        return menu

    def play_pause(self, source):
        self.run_command("playerctl play-pause")

    def next_track(self, source):
        self.run_command("playerctl next")

    def prev_track(self, source):
        self.run_command("playerctl previous")

    def stop_track(self, source):
        self.run_command("playerctl stop")

    def a_play_pause(self, source):
        self.run_command("playerctl -a play-pause")

    def a_next_track(self, source):
        self.run_command("playerctl -a next")

    def a_prev_track(self, source):
        self.run_command("playerctl -a previous")

    def a_stop(self, source):
        self.run_command("playerctl -a stop")

    def run_command(self, command):
        subprocess.run(command, shell=True)

    def quit(self, source):
        Gtk.main_quit()

def main():
    app = playerctl_systray()
    Gtk.main()

if __name__ == "__main__":
    main()
