#!/bin/zsh

nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | xargs printf "%'02d%%"

