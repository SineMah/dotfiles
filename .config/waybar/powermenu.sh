#!/bin/bash

options=" Lock\n󰗽 Logout\n󰜉 Reboot\n Shutdown"

choice=$(echo -e "$options" | rofi -dmenu -i -p "Power")

case "$choice" in
  " Lock")
    swaylock -i /home/sine/.config/sway/bg00.jpg ;;
  "󰗽 Logout")
    swaymsg exit ;;
  "󰜉 Reboot")
    systemctl reboot ;;
  " Shutdown")
    systemctl poweroff ;;
esac

