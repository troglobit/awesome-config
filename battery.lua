-- This function returns a formatted string with the current battery status. It
-- can be used to populate a text widget in the awesome window manager. Based
-- on the "Gigamo Battery Widget" found in the wiki at awesome.naquadah.org
-- https://github.com/koenwtje/awesome-batteryInfo

local naughty = require("naughty")
local beautiful = require("beautiful")

function readBatFile(adapter, ...)
   local basepath = "/sys/class/power_supply/"..adapter.."/"
   for i, name in pairs({...}) do
      file = io.open(basepath..name, "r")
      if file then
	 local str = file:read()
	 file:close()
	 return str
      end
   end
end

function batteryInfo(adapter)
   local fh = io.open("/sys/class/power_supply/"..adapter.."/present", "r")
   if fh == nil then
      battery = "A/C"
      icon = ""
      percent = ""
   else
      local cur = readBatFile(adapter, "charge_now", "energy_now")
      local cap = readBatFile(adapter, "charge_full", "energy_full")
      local sta = readBatFile(adapter, "status")

      if (cur and cap) then
	 battery = math.floor(cur * 100 / cap)
      else
	 battery = 0
	 sta = "None"
      end

      if sta:match("Charging") then
	 icon = "⚡"
	 percent = "%"
      elseif sta:match("Discharging") then
	 icon = ""
	 percent = "%"
	 if tonumber(battery) < 10 and adapter == "BAT0" then
	    naughty.notify({
		  title    = "Battery Warning"
		  , text     = "Battery low!".."  "..battery..percent.."  ".."left!"
		  , timeout  = 30
		  , position = "top_right"
		  , fg       = beautiful.fg_focus
		  , bg       = beautiful.bg_focus
	    })
	 end
      elseif sta:match("None") then
	 battery = "N/A"
	 icon = ""
	 percent = ""
      else -- sta == Unknown
--	 -- Neither charging or discharging, assume we're the secondary battery
--	 battery = "100"
--	 icon = "⚡"
	 percent = "%"
      end
   end
   return adapter..": "..icon..battery..percent.." "
end
