#!/bin/zsh

wifi=$(nmcli radio wifi)

type="Wifi"
con="󰖩"
color=""

if [[ "$wifi" == "disabled" ]]; then
  type=" Eth"
fi

nc -z -w 5 8.8.8.8 53 >/dev/null 2>&1
online=$?

if [ $online -ne 0 ]; then
  con="󱚼"
  color="%{F#cc241d}"
fi

echo $color$type $con

