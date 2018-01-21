#!/usr/bin/env lua

local randr = {}

function trim(s)
      return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function randr.init(cmd)
   outputs = {}
   xrandr = io.popen("xrandr -q")
   for line in xrandr:lines() do
      output, status = line:match("^([^ ]*) ([^ ]*connected).*")
      if output then
	 table.insert(outputs, {output, status})
      end
   end
   xrandr:close()

   for i,v in ipairs(outputs) do
      out, stat = table.unpack(v)
      os.execute(string.format("%s display %s %s", cmd, out, stat))
   end

   inputs = {}
   xinput = io.popen("xinput list --short")
   for line in xinput:lines() do
      if (line:match(".*slave .*")) then
	 desc, id, input = line:match(".*↳ (.*)id=([0-9]*).*slave  ([^ ]*).*")
	 os.execute(string.format("%s %s %s connected %s", cmd, input, id, trim(desc)))
      end
   end
   xinput:close()
end

return randr
