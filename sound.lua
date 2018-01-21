#!/usr/bin/env lua
local sink_id = -1

local sound = {}

function sound.init()
   fallback = 0
   bluez = -1

   pactl = io.popen("pactl list sinks short")
   for line in pactl:lines() do
      sink, card = line:match("^([0-9]*)[ \t]*([^ \t]*).*")

      if card:match(".*DisplayLink.*") then
	 sink_id = tonumber(sink)
      end
      if card:match(".*alsa_output.*") then
	 fallback = tonumber(sink)
      end
      if card:match(".*bluez_sink.*") then
      	 bluez = tonumber(sink)
      end
   end
   pactl:close()

   if sink_id == -1 then
      sink_id = fallback
   end
   if bluez ~= -1 then
      sink_id = bluez
   end
end

function sound.incr()
   os.execute("pactl set-sink-volume " .. sink_id .. " +5%")
end

function sound.decr()
   os.execute("pactl set-sink-volume " .. sink_id .. " -5%")
end

function sound.mute()
   os.execute("pactl set-sink-mute " .. sink_id .. " toggle")
end

return sound
