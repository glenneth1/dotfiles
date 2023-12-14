#!/usr/bin/env bash


### Check if python-pywal is installed
### Check if dir exists and copy the template in its proper place
if [ -x "$(command -v wal)" ]; then
    my_array=($HOME/.config/dk/backgrounds/*)
    wal -i ${my_array[$(( $RANDOM % ${#my_array[@]}))]} -a 80
else
  # Set background
  if [ -x "$(command -v feh)" ]; then
    feh --randomize --bg-fill $HOME/.config/dk/backgrounds/*
  fi
fi
