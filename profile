# Screen stuff
xrandr --output HDMI-0 --off
xrandr --output DP-0 --mode 2560x1440 --pos 2560x0 --rate 144
xrandr --output DP-2 --mode 2560x1440 --rate 144

# Wallpaper
feh --bg-scale /home/david/Nextcloud/Pictures/mountain.jpg

# Mouse Accel
xinput --set-prop "Logitech Gaming Mouse G502" "libinput Accel Profile Enabled" 0, 0, 0
xinput --set-prop "Logitech Gaming Mouse G502" "Coordinate Transformation Matrix" 1.2 0.0 0.0 0.0 1.2 0.0 0.0 0.0 1.3

# Keyboard repetition
xset r rate 200 25
