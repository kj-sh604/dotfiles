#!/bin/sh

# Prompt the user for automatic timezone setting
echo "Do you want to automatically set the timezone based on your location? [y/n]"
read -r automatic_timezone_input

if [ "$automatic_timezone_input" = "y" ] || [ "$automatic_timezone_input" = "Y" ]; then
  # Set the system timezone automatically based on location
  automatic_timezone=$(curl --fail https://ipapi.co/timezone 2>/dev/null)
  if [ -n "$automatic_timezone" ]; then
    sudo timedatectl set-timezone "$automatic_timezone"
    echo "Automatic timezone setting complete."
  else
    echo "Automatic timezone setting failed. Please set the timezone manually."
  fi
else
  # Prompt the user for timezone input
  echo "Enter the desired timezone (e.g., America/New_York):"
  read -r timezone_input

  # Set the system timezone
  sudo timedatectl set-timezone "$timezone_input"
fi

# Prompt the user for automatic time setting
echo "Do you want to set the time automatically? [y/n]"
read -r automatic_time_input

if [ "$automatic_time_input" = "y" ] || [ "$automatic_time_input" = "Y" ]; then
  # Synchronize the system time automatically using NTP
  sudo timedatectl set-ntp true
  echo "Automatic time synchronization using NTP initiated."
else
  # Prompt the user for date and time input
  echo "Enter the desired date (format: YYYY-MM-DD):"
  read -r date_input
  echo "Enter the desired time (format: HH:MM:SS):"
  read -r time_input
  
  # Override NTP setting
  sudo timedatectl set-ntp false

  # Set the system date and time
  sudo timedatectl set-time "$date_input $time_input"
  echo "Manual date and time setting complete."
fi