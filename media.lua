#!/usr/bin/env lua

local media = {}

local cmd = "dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 "

function media.play()
   p = cmd .. "org.mpris.MediaPlayer2.Player.PlayPause"
   os.execute(p)
end

function media.stop()
   os.execute(cmd .. "org.mpris.MediaPlayer2.Player.Stop")
end

function media.next()
   os.execute(cmd .. "org.mpris.MediaPlayer2.Player.Next")
end

function media.prev()
   os.execute(cmd .. "org.mpris.MediaPlayer2.Player.Previous")
end

return media
