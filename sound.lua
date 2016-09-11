#!/usr/bin/env lua
local sink_id = {}

sound = {}
function sound.init()
   fallback = {}

   pactl = io.popen("pactl list sinks short")
   for line in pactl:lines() do
      sink, card = line:match("^([0-9]*)[ \t]*([^ \t]*).*")
      fallback = sink
      if card:match(".*DisplayLink.*") then
	 sink_id = tonumber(sink)
      end
   end
   pactl:close()

   if not sink_id then
      sink_id = tonumber(fallback)
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
