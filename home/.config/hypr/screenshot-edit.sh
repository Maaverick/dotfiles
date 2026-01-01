#!/bin/bash
temp_file=$(mktemp --suffix=.png)
grim -g "$(slurp)" "$temp_file"
swappy -f "$temp_file"
rm "$temp_file"
