#!/usr/bin/env lua

randr = {}
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
      out, stat = unpack(v)
      --   print(string.format("%s = %s", out, stat))
      os.execute(string.format("%s display %s %s", cmd, out, stat))
   end
end

