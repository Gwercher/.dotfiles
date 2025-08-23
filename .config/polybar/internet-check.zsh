#!/bin/zsh

wifi=$(nmcli radio wifi)

if [[ "$wifi" == "disabled" ]]; then
  echo "%{F#928374}Wifi"
  exit
fi

nc -z -w 5 8.8.8.8 53 >/dev/null 2>&1
online=$?

if [ $online -eq 0 ]; then
  echo "Wifi"
else
  echo "%{F#cc241d}Wifi"
fi
