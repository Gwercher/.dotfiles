#!/bin/zsh

sensors | grep Tctl | sed 's/.*+//' | sed 's/°C//' | xargs printf '%.0f°C'
