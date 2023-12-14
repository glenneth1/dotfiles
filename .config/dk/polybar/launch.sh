#!/usr/bin/env sh

# More info : https://github.com/jaagr/polybar/wiki

# Install the following applications for polybar and icons in polybar if you are on ArcoLinuxD
# awesome-terminal-fonts
# Tip : There are other interesting fonts that provide icons like nerd-fonts-complete
# --log=error

# if you see None-1-1 in your xrandr output as connected or something similar
# remove the last line with this
# xrandr --query | grep " connected" | cut -d" " -f1 | sed '$d' in line 27

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

desktop=$(echo $DESKTOP_SESSION)
count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)

case $desktop in

    dk|/usr/share/xsessions/dk)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-dk -c ~/.config/dk/polybar/config.ini &
      done
    else
    polybar --reload mainbar-dk -c ~/.config/dk/polybar/config.ini &
    fi
esac
