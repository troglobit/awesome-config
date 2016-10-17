#!/bin/sh
killall gnome-screensaver
exec xautolock -detectsleep \
     -time 15 -locker "xscreensaver-command -lock" \
     -notify 30 \
     -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'"
