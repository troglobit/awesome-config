#!/usr/bin/env lua
local sound = {}

function sound.incr()
   os.execute("pactl set-sink-volume @DEFAULT_SINK@ +5%")
end

function sound.decr()
   os.execute("pactl set-sink-volume @DEFAULT_SINK@ -5%")
end

function sound.mute()
   os.execute("pactl set-sink-mute @DEFAULT_SINK@ toggle")
end

return sound
