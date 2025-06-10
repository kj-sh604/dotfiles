import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib
import subprocess

class dateTimeSetter(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="dateTimeSetter")
        self.set_border_width(10)
        self.set_default_size(400, 300)

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(vbox)

        # Automatic time setting checkbox
        automatic_time_label = Gtk.Label(label="Set the date, time, and timezone automatically?")
        vbox.pack_start(automatic_time_label, False, False, 0)

        self.automatic_time_check = Gtk.CheckButton(label="Yes")
        self.automatic_time_check.connect("toggled", self.on_automatic_time_toggled)
        vbox.pack_start(self.automatic_time_check, False, False, 0)

        # Date and time entry fields
        date_label = Gtk.Label(label="Enter the desired date (format: YYYY-MM-DD):")
        vbox.pack_start(date_label, False, False, 0)

        self.date_entry = Gtk.Entry()
        vbox.pack_start(self.date_entry, False, False, 0)

        time_label = Gtk.Label(label="Enter the desired time (format: HH:MM:SS):")
        vbox.pack_start(time_label, False, False, 0)

        self.time_entry = Gtk.Entry()
        vbox.pack_start(self.time_entry, False, False, 0)

        # Timezone entry field
        timezone_label = Gtk.Label(label="Enter the desired timezone (e.g., America/New_York):")
        vbox.pack_start(timezone_label, False, False, 0)

        self.timezone_entry = Gtk.Entry()
        vbox.pack_start(self.timezone_entry, False, False, 0)

        # Apply button
        apply_button = Gtk.Button(label="Apply")
        apply_button.connect("clicked", self.on_apply_clicked)
        vbox.pack_start(apply_button, False, False, 0)

    def on_automatic_time_toggled(self, button):
        if button.get_active():
            self.date_entry.set_sensitive(False)
            self.time_entry.set_sensitive(False)
            self.timezone_entry.set_sensitive(False)
        else:
            self.date_entry.set_sensitive(True)
            self.time_entry.set_sensitive(True)
            self.timezone_entry.set_sensitive(True)

    def on_apply_clicked(self, button):
        automatic_time = self.automatic_time_check.get_active()

        if automatic_time:
            subprocess.run(["timedatectl", "set-ntp", "true"])
            print("Automatic time synchronization using NTP initiated.")

            automatic_timezone_output = subprocess.run(["curl", "--fail", "https://ipapi.co/timezone"], capture_output=True, text=True)
            automatic_timezone = automatic_timezone_output.stdout.strip()

            if automatic_timezone:
                subprocess.run(["timedatectl", "set-timezone", automatic_timezone])
                print("Automatic timezone setting complete.")
            else:
                print("Automatic timezone setting failed. Please set the timezone manually.")
        else:
            date_input = self.date_entry.get_text()
            time_input = self.time_entry.get_text()
            timezone_input = self.timezone_entry.get_text()

            subprocess.run(["timedatectl", "set-ntp", "false"])
            subprocess.run(["timedatectl", "set-time", f"{date_input} {time_input}"])
            subprocess.run(["timedatectl", "set-timezone", timezone_input])
            print("Manual date, time, and timezone setting complete.")


win = dateTimeSetter()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()
