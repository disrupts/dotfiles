#!/bin/sh
pkill polybar
case $DEVICE in
"Desktop")
    polybar landscape-time-desktop    2>&1 | tee -a /tmp/polybar_landscape_time.log    & # disown
    polybar landscape-date-desktop    2>&1 | tee -a /tmp/polybar_landscape_date.log    & # disown
    polybar landscape-xwindow-desktop 2>&1 | tee -a /tmp/polybar_landscape_xwindow.log & # disown
    ;;
"Laptop")
    polybar landscape-time-laptop    2>&1 | tee -a /tmp/polybar_landscape_time.log    & # disown
    polybar landscape-date-laptop    2>&1 | tee -a /tmp/polybar_landscape_date.log    & # disown
    polybar landscape-xwindow-laptop 2>&1 | tee -a /tmp/polybar_landscape_xwindow.log & # disown
    ;;
*)
    echo "Configue \$DEVICE to either Desktop or Laptop."
    echo "polybar not started."
    ;;
esac
