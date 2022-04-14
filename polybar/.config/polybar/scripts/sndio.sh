#/bin/sh

volume=`sndioctl -n output.level | cut -d '.' -f2`
volume=`expr $volume / 10`
mute=`sndioctl -n output.mute`

if [ $mute = 1 ]; then
    echo "🔇"
else
    if [ $volume -ge 66 ]; then
        echo "🔊"
    elif [ $volume -ge 33 ]; then
        echo "🔉"
    else
        echo "🔈"
    fi
fi

unset -v mute volume 
