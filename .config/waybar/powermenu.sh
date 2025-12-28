#!/bin/bash

options=" Lock\n󰗽 Logout\n󰜉 Reboot\n Shutdown"

choice=$(echo -e "$options" | rofi -dmenu -i -p "Power")

case "$choice" in
  " Lock")
    hyprlock ;;
  "󰗽 Logout")
    hyprctl dispatch exit ;;
  "󰜉 Reboot")
    systemctl reboot ;;
  " Shutdown")
    systemctl poweroff ;;
esac

