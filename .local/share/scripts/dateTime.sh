#!/bin/sh

# Prompt the user for automatic time setting
echo "Do you want to set the date, time, and timezone automatically? [y/n]"
read -r automatic_time_input

if [ "$automatic_time_input" = "y" ] || [ "$automatic_time_input" = "Y" ]; then
	# Synchronize the system time automatically using NTP
	timedatectl set-ntp true
	echo "Automatic time synchronization using NTP initiated."
	automatic_timezone=$(curl --fail https://ipapi.co/timezone 2>/dev/null)
	if [ -n "$automatic_timezone" ]; then
		timedatectl set-timezone "$automatic_timezone"
		echo "Automatic timezone setting complete."
	else
		echo "Automatic timezone setting failed. Please set the timezone manually."
	fi
else
	# Prompt the user for date and time input
	echo "Enter the desired date (format: YYYY-MM-DD):"
	read -r date_input
	echo "Enter the desired time (format: HH:MM:SS):"
	read -r time_input
	# Prompt the user for timezone input
	echo "Enter the desired timezone (e.g., America/New_York):"
	read -r timezone_input

	# Override NTP setting
	timedatectl set-ntp false

	# Set the system date and time
	timedatectl set-time "$date_input $time_input"
	# Set the system timezone
	timedatectl set-timezone "$timezone_input"
	echo "Manual date and time setting complete."
fi
