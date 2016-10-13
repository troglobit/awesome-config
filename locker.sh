#!/bin/sh

exec xautolock -detectsleep \
     -time 15 -locker "gnome-screensaver-command -l" \
     -notify 30 \
     -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'"
