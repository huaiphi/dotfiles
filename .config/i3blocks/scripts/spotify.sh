#!/usr/bin/bash

set -e

player="spotify"

if [ $(playerctl status --player=$player) == "Playing" ]; then
    echo $(playerctl metadata --format "{{ artist }} - {{ title }}" --player=$player)
else
    echo
fi

