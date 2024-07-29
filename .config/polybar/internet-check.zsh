#!/bin/zsh

nc -z -w 5 8.8.8.8 53  >/dev/null 2>&1
online=$?

if [ $online -eq 0 ]; then
  echo "Online"
else
# echo $(date +%d-%m-%y\ %H:%M:%S) >> ~/internet-status/$(date +%m-%y)
  echo "%{F#cc241d}Offline"
fi
