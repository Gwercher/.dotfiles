#!/bin/zsh

if nc -zw1 google.com 443; then
  echo "Online"
else
  echo $(date +%d-%m-%y\ %H:%M:%S) >> ~/internet-status/$(date +%m-%y)
  # echo "%{F#e51515}Offline"
  echo "%{F#cc241d}Offline"
fi
