#!/bin/sh

# Sets machine type
export DEVICE="Desktop"     # values: 'Desktop', 'Laptop'
export OS="`uname -s`"      # values: 'OpenBSD', 'Linux'

# change locale
export LC_CTYPE="en_GB.UTF-8"

# loading .Xresources
xrdb -merge -I$HOME ~/.Xresources

# set the cursor & default background
xsetroot -cursor_name left_ptr -solid steelblue

xset b off         # stop the bell
xset r rate 350 35 # autorepeate rate

# Mouse configurations
case $DEVICE in
"Desktop")
    # slow down mouse to make it behave similarly as windows with the same dpi
    mouse_id='pointer:Logitech G305' # other mouse 'Kingsis Peripherals ZOWIE Gaming mouse'
    speed=0.5 # default is 1
    xinput --set-prop "$mouse_id" 'Coordinate Transformation Matrix' $speed 0.0 0.0 0.0 $speed 0.0 0.0 0.0 1
    ;;
"Laptop")
    # change mouse accel & threshold
    # xset m 1 10    # trackpad/trackpoing

    # middle button scroll
    xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation" 1
    xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Button" 2
    xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Axes" 6 7 4 5
    ;;
*)
    echo "Configure \$DEVICE to either Desktop or Laptop."
    ;;
esac


# screen saving/locking
xset s off      # disable built-in, xidle handles it
xset dpms 0 0 0 # disable dpm,      slock handles it
case $OS in
"Openbsd") SLOCK=/usr/local/bin/slock ;;
"Linux")   SLOCK=/usr/bin/slock ;;
*)         echo "OS not supported." ;;
esac
xidle -timeout 300 -ne -program $SLOCK & # ~/scripts/lock not defined
unset -v SLOCK

# hide cursor when typing, not needed so much with kitty
#xbanish &

# Screen utilities
case $DEVICE in
"Laptop")
    # xdimmer -ka & # dims the screen after some time
    xdimmer & # can't find ambient light sensor (-a) & keybaord backlight error (-k)
    xcalib ~/.icc/x1c3qhd.icc
    ;;
"Desktop")
    # xcalib ~/.icc/samsung_C24FG73_user.icm # screen 0 includes all monitors :/
    ;;
*)
    echo "Configure \$DEVICE to either Desktop or Laptop."
    ;;
esac


# Monitor setup
case $DEVICE in
"Laptop")
    # autorandr may be used, defaulting to internal monitor
    ;;
"Desktop")
    # dual monitor setup
    xrandr --output DP-0   --preferred --mode 1920x1080 --size 1920x1080 --rate 144
    xrandr --output HDMI-0 --preferred --right-of DP-0 --rotate right --mode 1920x1080 --size 1920x1080 --rate 60
    ;;
*)
    # nothing by default
    ;;
esac


# set wallpaper & change terminal colours
$HOME/backgrounds/wallpaper.py
#recolor $wallpath/$wallpaper | toxrdb | xrdb -merge &
# are those & ok... those processes will end

# Laptop specific things
# trackpad & touchpad config
#CURRENT_OS='OpenBSD' ~/.touchpadrc
# Set keyboard and remaps needs to be after feh & compton for xmodmap to work
#CURRENT_OS='OpenBSD' ~/.keyboardrc
#xmodmap -pke > ~/.Xmodmap #generate file for fictx to call

if [ "$DEVICE" = "Laptop" ]; then
    setxkbmap -option caps:ctrl_modifier
fi

# sound, ALSA only stuff
if [ "$OS" = "Linux" ]; then
    export ALSA_CARD="PCH"
fi


# start compositor
picom --experimental-backends --config $HOME/.config/picom/picom.$DEVICE.$OS.conf &

# wm bar
#basic_bar | basic_bar_launcher &
$HOME/.config/polybar/bar.sh

# Launch sxhkd and bspwm
# sxhkd -m 1/-1 for laptop
# but even in that case it should no be needed if keymap is changed before this?
cat ~/.sxhkd/* > /tmp/sxhkdrc && sxhkd -c /tmp/sxhkdrc 2>&1 > /tmp/sxhkd.log &
bspwm -c ~/.bspwmrc                                    2>&1 > /tmp/bspwm.log


# cleanup based on jcs/dotfiles/.xsession
echo "cleaning up xsession"
pkill picom polybar # ssh-agent-card-prompt dbus-daemon
rm -rf ~/.local/share/Trash
rm -f ~/.Xauthority
