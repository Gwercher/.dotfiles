#!/bin/zsh

echo "$(grep 'cpu ' /proc/stat | awk '{cpu_usage=($2+$4)*100/($2+$4+$5)}
END {printf "%02.0f%", cpu_usage}')"
