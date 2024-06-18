import tkinter as tk
from tkinter import ttk, messagebox
import subprocess
import requests
import datetime
import pytz
import time


class DateTimeSetter(tk.Tk):
    def __init__(self):
        super().__init__()

        self.title("dateTimeSetter")
        self.geometry("640x480")
        self.resizable(True, True)
        self.attributes("-type", "dialog")  # make the window floating

        self.create_widgets()
        self.populate_fields()

    def create_widgets(self):
        # automatic time setting checkbox
        automatic_time_label = ttk.Label(
            self, text="Set the date, time, and timezone automatically?")
        automatic_time_label.pack(pady=5)

        self.automatic_time_check = ttk.Checkbutton(
            self, text="Yes", command=self.on_automatic_time_toggled)
        self.automatic_time_check.pack(pady=5)

        # date entry fields
        date_frame = ttk.LabelFrame(self, text="Date")
        date_frame.pack(pady=10, padx=10, fill="x")

        ttk.Label(date_frame, text="YYYY:").grid(
            row=0, column=0, padx=5, pady=5)
        self.year_var = tk.StringVar()
        self.year_combo = ttk.Combobox(date_frame, textvariable=self.year_var, values=[str(
            year) for year in range(1970, 2039)], state="normal")
        self.year_combo.grid(row=0, column=1, padx=5, pady=5)

        ttk.Label(date_frame, text="MM:").grid(row=0, column=2, padx=5, pady=5)
        self.month_var = tk.StringVar()
        self.month_combo = ttk.Combobox(date_frame, textvariable=self.month_var, values=[str(
            month) for month in range(1, 13)], state="normal")
        self.month_combo.grid(row=0, column=3, padx=5, pady=5)

        ttk.Label(date_frame, text="DD:").grid(row=0, column=4, padx=5, pady=5)
        self.day_var = tk.StringVar()
        self.day_combo = ttk.Combobox(
            date_frame, textvariable=self.day_var, values=[str(day) for day in range(1, 32)], state="normal")
        self.day_combo.grid(row=0, column=5, padx=5, pady=5)

        # time entry fields
        time_frame = ttk.LabelFrame(self, text="Time (24hr)")
        time_frame.pack(pady=10, padx=10, fill="x")

        ttk.Label(time_frame, text="   HH:").grid(
            row=0, column=0, padx=5, pady=5)
        self.hour_var = tk.StringVar()
        self.hour_combo = ttk.Combobox(time_frame, textvariable=self.hour_var, values=[str(
            hour) for hour in range(0, 24)], state="normal")
        self.hour_combo.grid(row=0, column=1, padx=5, pady=5)

        ttk.Label(time_frame, text="MM:").grid(row=0, column=2, padx=5, pady=5)
        self.minute_var = tk.StringVar()
        self.minute_combo = ttk.Combobox(time_frame, textvariable=self.minute_var, values=[str(
            minute) for minute in range(0, 60)], state="normal")
        self.minute_combo.grid(row=0, column=3, padx=5, pady=5)

        ttk.Label(time_frame, text="SS:").grid(row=0, column=4, padx=5, pady=5)
        self.second_var = tk.StringVar()
        self.second_combo = ttk.Combobox(time_frame, textvariable=self.second_var, values=[str(
            second) for second in range(0, 60)], state="normal")
        self.second_combo.grid(row=0, column=5, padx=5, pady=5)

        # timezone entry field
        timezone_frame = ttk.LabelFrame(self, text="Timezone")
        timezone_frame.pack(pady=10, padx=10, fill="x")

        ttk.Label(timezone_frame, text="Timezone:").grid(
            row=0, column=0, padx=5, pady=5)
        self.timezone_var = tk.StringVar()
        self.timezone_combo = ttk.Combobox(
            timezone_frame, textvariable=self.timezone_var, values=pytz.all_timezones, state="normal")
        self.timezone_combo.grid(row=0, column=1, padx=5, pady=5)

        # set-local-rtc checkbox
        self.local_rtc_check = ttk.Checkbutton(
            timezone_frame, text="Set local RTC")
        self.local_rtc_check.grid(
            row=1, column=0, columnspan=2, padx=5, pady=5)

        # apply button
        button_frame = ttk.Frame(self)
        button_frame.pack(pady=20)

        self.apply_button = ttk.Button(
            button_frame, text="Apply All", command=self.on_apply_clicked)
        self.apply_button.grid(row=0, column=0, padx=5)

        self.timezone_apply_button = ttk.Button(
            button_frame, text="Apply Timezone", command=self.on_timezone_apply_clicked)
        self.timezone_apply_button.grid(row=0, column=1, padx=5)

        self.date_time_apply_button = ttk.Button(
            button_frame, text="Apply Date & Time", command=self.on_date_time_apply_clicked)
        self.date_time_apply_button.grid(row=0, column=2, padx=5)

        self.local_rtc_apply_button = ttk.Button(
            button_frame, text="Apply Local RTC", command=self.on_local_rtc_apply_clicked)
        self.local_rtc_apply_button.grid(row=0, column=3, padx=5)

        self.update_apply_button_state()

        # Set trace on all variables to call update_apply_button_state when they change
        self.year_var.trace_add("write", self.update_apply_button_state)
        self.month_var.trace_add("write", self.update_apply_button_state)
        self.day_var.trace_add("write", self.update_apply_button_state)
        self.hour_var.trace_add("write", self.update_apply_button_state)
        self.minute_var.trace_add("write", self.update_apply_button_state)
        self.second_var.trace_add("write", self.update_apply_button_state)
        self.timezone_var.trace_add("write", self.update_apply_button_state)

    def on_automatic_time_toggled(self):
        if self.automatic_time_check.instate(['selected']):
            self.year_combo.state(['disabled'])
            self.month_combo.state(['disabled'])
            self.day_combo.state(['disabled'])
            self.hour_combo.state(['disabled'])
            self.minute_combo.state(['disabled'])
            self.second_combo.state(['disabled'])
            self.timezone_combo.state(['disabled'])
        else:
            self.year_combo.state(['!disabled'])
            self.month_combo.state(['!disabled'])
            self.day_combo.state(['!disabled'])
            self.hour_combo.state(['!disabled'])
            self.minute_combo.state(['!disabled'])
            self.second_combo.state(['!disabled'])
            self.timezone_combo.state(['!disabled'])
        self.update_apply_button_state()

    def update_apply_button_state(self, *_):
        if self.automatic_time_check.instate(['selected']):
            self.apply_button.state(['!disabled'])
            self.timezone_apply_button.state(['disabled'])
            self.date_time_apply_button.state(['disabled'])
            self.local_rtc_apply_button.state(['disabled'])
        else:
            all_date_filled = all([
                self.year_combo.get(),
                self.month_combo.get(),
                self.day_combo.get(),
            ])
            all_time_filled = all([
                self.hour_combo.get(),
                self.minute_combo.get(),
                self.second_combo.get(),
            ])
            timezone_filled = self.timezone_combo.get()
            all_filled = all_date_filled and all_time_filled and timezone_filled

            if all_filled:
                self.apply_button.state(['!disabled'])
            else:
                self.apply_button.state(['disabled'])

            if timezone_filled and self.validate_timezone(timezone_filled):
                self.timezone_apply_button.state(['!disabled'])
            else:
                self.timezone_apply_button.state(['disabled'])

            if all_date_filled and all_time_filled:
                self.date_time_apply_button.state(['!disabled'])
            else:
                self.date_time_apply_button.state(['disabled'])

            self.local_rtc_apply_button.state(['!disabled'])

    def on_apply_clicked(self):
        automatic_time = self.automatic_time_check.instate(['selected'])
        local_rtc = self.local_rtc_check.instate(['selected'])

        if automatic_time:
            subprocess.run(["timedatectl", "set-ntp", "true"])

            try:
                automatic_timezone_output = subprocess.run(
                    ["curl", "--fail", "https://ipinfo.io/timezone"], capture_output=True, text=True)
                automatic_timezone = automatic_timezone_output.stdout.strip()

                if automatic_timezone:
                    subprocess.run(
                        ["timedatectl", "set-timezone", automatic_timezone])
                    messagebox.showinfo(
                        "Info", "Automatic date, time, and timezone setting complete.")
                else:
                    messagebox.showwarning(
                        "Warning", "Automatic date, time, and timezone setting failed. Please try again or use timedatectl.")
            except requests.RequestException:
                messagebox.showwarning(
                    "Warning", "Failed to fetch date, time, and timezone information. Please try again or use timedatectl.")
        else:
            try:
                date_input = f"{self.year_combo.get()}-{int(self.month_combo.get()):02d}-{int(self.day_combo.get()):02d}"
                time_input = f"{int(self.hour_combo.get()):02d}:{int(self.minute_combo.get()):02d}:{int(self.second_combo.get()):02d}"
                timezone_input = self.timezone_combo.get()

                # check for invalid numbers in fields
                if not all([
                    self.validate_number(self.year_combo.get(), 1970, 2038),
                    self.validate_number(self.month_combo.get(), 1, 12),
                    self.validate_number(self.day_combo.get(), 1, 31),
                    self.validate_number(self.hour_combo.get(), 0, 23),
                    self.validate_number(self.minute_combo.get(), 0, 59),
                    self.validate_number(self.second_combo.get(), 0, 59),
                    self.validate_timezone(timezone_input)
                ]):
                    messagebox.showerror(
                        "Error", "Invalid number entered in one or more fields.")
                    return

                subprocess.run(["timedatectl", "set-ntp", "false"])
                time.sleep(1)
                subprocess.run(["timedatectl", "set-timezone", timezone_input])
                time.sleep(1)
                subprocess.run(["timedatectl", "set-time",
                               f"{date_input} {time_input}"])
                messagebox.showinfo(
                    "Info", "Manual date, time, and timezone setting complete.")
            except ValueError as e:
                messagebox.showerror("Error", f"Error:\n{e}\n\nOne or more blank fields!")

        # handle local rtc setting
        if local_rtc:
            subprocess.run(["timedatectl", "set-local-rtc", "1"])
        else:
            subprocess.run(["timedatectl", "set-local-rtc", "0"])

    def on_timezone_apply_clicked(self):
        timezone_input = self.timezone_combo.get()

        if not timezone_input or not self.validate_timezone(timezone_input):
            messagebox.showerror("Error", "Invalid or empty timezone field.")
            return

        try:
            subprocess.run(["timedatectl", "set-timezone", timezone_input])
            messagebox.showinfo(
                "Info", "Timezone setting complete.")
        except subprocess.CalledProcessError as e:
            messagebox.showerror("Error", f"Error setting timezone:\n{e}")

    def on_date_time_apply_clicked(self):
        try:
            date_input = f"{self.year_combo.get()}-{int(self.month_combo.get()):02d}-{int(self.day_combo.get()):02d}"
            time_input = f"{int(self.hour_combo.get()):02d}:{int(self.minute_combo.get()):02d}:{int(self.second_combo.get()):02d}"

            # check for invalid numbers in fields
            if not all([
                self.validate_number(self.year_combo.get(), 1970, 2038),
                self.validate_number(self.month_combo.get(), 1, 12),
                self.validate_number(self.day_combo.get(), 1, 31),
                self.validate_number(self.hour_combo.get(), 0, 23),
                self.validate_number(self.minute_combo.get(), 0, 59),
                self.validate_number(self.second_combo.get(), 0, 59),
            ]):
                messagebox.showerror(
                    "Error", "Invalid number entered in one or more fields.")
                return

            subprocess.run(["timedatectl", "set-ntp", "false"])
            time.sleep(1)
            subprocess.run(["timedatectl", "set-time", f"{date_input} {time_input}"])
            messagebox.showinfo(
                "Info", "Manual date and time setting complete.")
        except ValueError as e:
            messagebox.showerror("Error", f"Error:\n{e}\n\nOne or more blank fields!")

    def on_local_rtc_apply_clicked(self):
        local_rtc = self.local_rtc_check.instate(['selected'])

        if local_rtc:
            subprocess.run(["timedatectl", "set-local-rtc", "1"])
            messagebox.showinfo("Info", "Local RTC setting enabled.")
        else:
            subprocess.run(["timedatectl", "set-local-rtc", "0"])
            messagebox.showinfo("Info", "Local RTC setting disabled.")

    def validate_number(self, value, min_val, max_val):
        try:
            num = int(value)
            return min_val <= num <= max_val
        except ValueError:
            return False

    def validate_timezone(self, timezone):
        return timezone in pytz.all_timezones

    def populate_fields(self):
        now = datetime.datetime.now()
        self.year_combo.set(now.year)
        self.month_combo.set(now.month)
        self.day_combo.set(now.day)
        self.hour_combo.set(now.hour)
        self.minute_combo.set(now.minute)
        self.second_combo.set(now.second)

        try:
            current_timezone = subprocess.check_output(
                ["timedatectl", "show", "--property=Timezone"]).decode().strip().split("=")[1]
            self.timezone_combo.set(current_timezone)
        except subprocess.CalledProcessError:
            pass

        try:
            ntp_status = subprocess.check_output(
                ["timedatectl", "show", "--property=NTP"]).decode().strip().split("=")[1]
            if ntp_status == "yes":
                self.automatic_time_check.state(['selected'])
                self.on_automatic_time_toggled()
            else:
                self.automatic_time_check.state(['!selected'])
                self.on_automatic_time_toggled()
        except subprocess.CalledProcessError:
            pass

        try:
            local_rtc_status = subprocess.check_output(
                ["timedatectl", "show", "--property=LocalRTC"]).decode().strip().split("=")[1]
            if local_rtc_status == "yes":
                self.local_rtc_check.state(['selected'])
            else:
                self.local_rtc_check.state(['!selected'])
        except subprocess.CalledProcessError:
            pass

        self.year_combo.bind("<<ComboboxSelected>>",
                             self.update_apply_button_state)
        self.month_combo.bind("<<ComboboxSelected>>",
                              self.update_apply_button_state)
        self.day_combo.bind("<<ComboboxSelected>>",
                            self.update_apply_button_state)
        self.hour_combo.bind("<<ComboboxSelected>>",
                             self.update_apply_button_state)
        self.minute_combo.bind("<<ComboboxSelected>>",
                               self.update_apply_button_state)
        self.second_combo.bind("<<ComboboxSelected>>",
                               self.update_apply_button_state)
        self.timezone_combo.bind(
            "<<ComboboxSelected>>", self.update_apply_button_state)
        self.timezone_combo.bind(
            "<KeyRelease>", self.update_apply_button_state)


if __name__ == "__main__":
    app = DateTimeSetter()
    app.mainloop()
