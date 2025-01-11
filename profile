# Screen stuff
xrandr --output HDMI-0 --off
xrandr --output DP-2 --mode 2560x1440 --pos 2560x0 --rate 144
xrandr --output DP-4 --mode 2560x1440 --rate 144
xset dpms 2400 3000 3000

# Wallpaper
feh --bg-scale /home/david/Nextcloud/Pictures/mountain.jpg

# Mouse Accel
xinput --set-prop "Logitech USB Receiver" "Coordinate Transformation Matrix" 1.3 0.0 0.0 0.0 1.3 0.0 0.0 0.0 1.6
xinput --set-prop "Logitech USB Receiver" "libinput Accel Profile Enabled" 0, 1

# Keyboard repetition
xset r rate 175 28


gsettings set org.gnome.desktop.peripherals.mouse accel-profile flat
