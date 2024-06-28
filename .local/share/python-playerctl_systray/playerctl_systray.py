import gi
import subprocess

gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')
gi.require_version('GLib', '2.0')
from gi.repository import Gtk, AppIndicator3, GLib

class playerctl_systray:
    def __init__(self):
        self.last_instances = self.get_player_instances()
        self.indicator = AppIndicator3.Indicator.new(
            "media-control-app",
            "audio-x-generic",
            AppIndicator3.IndicatorCategory.APPLICATION_STATUS
        )
        self.indicator.set_status(AppIndicator3.IndicatorStatus.ACTIVE)
        self.indicator.set_menu(self.create_menu())

    def create_menu(self):
        menu = Gtk.Menu()

        instances = self.get_player_instances()
        if instances:
            for instance in instances:
                instance_submenu = Gtk.Menu()

                play_item = Gtk.MenuItem(label="play-pause")
                play_item.connect("activate", self.play_pause, instance)
                instance_submenu.append(play_item)

                next_item = Gtk.MenuItem(label="next")
                next_item.connect("activate", self.next_track, instance)
                instance_submenu.append(next_item)

                prev_item = Gtk.MenuItem(label="previous")
                prev_item.connect("activate", self.prev_track, instance)
                instance_submenu.append(prev_item)

                instance_menu_item = Gtk.MenuItem(label=instance)
                instance_menu_item.set_submenu(instance_submenu)
                menu.append(instance_menu_item)

            a_submenu = Gtk.Menu()

            a_pause_item = Gtk.MenuItem(label="pause")
            a_pause_item.connect("activate", self.a_pause)
            a_submenu.append(a_pause_item)

            a_play_item = Gtk.MenuItem(label="play")
            a_play_item.connect("activate", self.a_play)
            a_submenu.append(a_play_item)

            a_next_item = Gtk.MenuItem(label="next")
            a_next_item.connect("activate", self.a_next_track)
            a_submenu.append(a_next_item)

            a_prev_item = Gtk.MenuItem(label="previous")
            a_prev_item.connect("activate", self.a_prev_track)
            a_submenu.append(a_prev_item)

            a_menu_item = Gtk.MenuItem(label="-a")
            a_menu_item.set_submenu(a_submenu)
            menu.append(a_menu_item)
        else:
            no_players_item = Gtk.MenuItem(label="no players found")
            no_players_item.set_sensitive(False)  # greyed out
            menu.append(no_players_item)

        menu.append(Gtk.SeparatorMenuItem())  # separator

        quit_item = Gtk.MenuItem(label="quit")
        quit_item.connect("activate", self.quit)
        menu.append(quit_item)

        menu.show_all()
        return menu

    def get_player_instances(self):
        result = subprocess.run("playerctl -l", shell=True, capture_output=True, text=True)
        return result.stdout.strip().split('\n') if result.stdout.strip() else []

    def play_pause(self, _, instance):
        self.run_command(f"playerctl -p {instance} play-pause")

    def next_track(self, _, instance):
        self.run_command(f"playerctl -p {instance} next")

    def prev_track(self, _, instance):
        self.run_command(f"playerctl -p {instance} previous")

    def a_play(self, _):
        self.run_command("playerctl -a play")

    def a_pause(self, _):
        self.run_command("playerctl -a pause")

    def a_next_track(self, _):
        self.run_command("playerctl -a next")

    def a_prev_track(self, _):
        self.run_command("playerctl -a previous")

    def run_command(self, command):
        subprocess.run(command, shell=True)

    def quit(self, _):
        Gtk.main_quit()

    def refresh_menu(self):
        current_instances = self.get_player_instances()
        if current_instances != self.last_instances:
            self.indicator.set_menu(self.create_menu())
            self.last_instances = current_instances
        return True  # returns True so that timeout continues

def main():
    app = playerctl_systray()
    GLib.timeout_add(1024, app.refresh_menu)  # probably should be event-based in the future
    Gtk.main()

if __name__ == "__main__":
    main()
