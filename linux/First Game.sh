#!/bin/sh
printf '\033c\033]0;%s\a' First Game
base_path="$(dirname "$(realpath "$0")")"
"$base_path/First Game.x86_64" "$@"
