#!/bin/zsh

version=$(ls ~/.config/discord | sed -n "s/^.*\([0-9]\+.[0-9]\+.[0-9]\+\).*$/\1/p")

new_version=$(echo $version | awk -F. '{$NF = $NF + 1; print $0}' OFS=.)

URL="https://dl.discordapp.net/apps/linux/$new_version/discord-$new_version.deb"

HTTP_STATUS=$(wget --spider --quiet --server-response $URL 2>&1 | grep "HTTP/" | tail -n 1 | awk '{print $2}')

if [ "$HTTP_STATUS" -ne 200 ]; then
    echo "no new discord version"
    exit 0
fi

OUTPUT_DIR=~/Downloads

wget --quiet -P $OUTPUT_DIR $URL

sudo dpkg -i $OUTPUT_DIR/discord-$new_version.deb > /dev/null 2>&1
rm $OUTPUT_DIR/discord-$new_version.deb

echo "updated discord"
