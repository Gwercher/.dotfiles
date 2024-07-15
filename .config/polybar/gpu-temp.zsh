#!/bin/zsh

nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits | xargs printf "%'d°C"

