#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#autorandr horizontal
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1834x1080 --rotate normal --output DP-1-0.1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-1-0 --off --output DP-1-1 --off --output HDMI-1-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1-2 --off

$HOME/.config/dk/polybar/launch.sh &

# there are several files in the folder - azerty, qwerty and original
run sxhkd -c ~/.config/dk/sxhkd/sxhkdrc &

#Some ways to set your wallpaper besides variety or nitrogen
#feh --bg-scale ~/.config/dk/wall.png &
feh --bg-fill /usr/share/backgrounds/archlinux/arch-wallpaper.jpg &
feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg &
#wallpaper for other Arch based systems
#feh --bg-fill /usr/share/archlinux-tweak-tool/data/wallpaper/wallpaper.png &
#feh --randomize --bg-fill ~/Dropbox/Apps/Desktoppr/*

dex $HOME/.config/autostart/arcolinux-welcome-app.desktop
xsetroot -cursor_name left_ptr &

conky -c $HOME/.config/dk/system-overview &
run variety &
run nm-applet &
run pamac-tray &
run xfce4-power-manager &
numlockx on &
blueberry-tray &
picom --config $HOME/.config/dk/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
run volumeicon &
#nitrogen --restore &
#run caffeine &
#run vivaldi-stable &
#run firefox &
#run thunar &
#run dropbox &
#run insync start &
#run discord &
#run spotify &
#run atom &
