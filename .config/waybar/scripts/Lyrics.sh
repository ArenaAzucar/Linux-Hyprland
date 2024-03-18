#!/bin/bash

url="$HOME/.config/waybar/scripts/songLyrics.sh"
bash $url | jq .Lyrics

