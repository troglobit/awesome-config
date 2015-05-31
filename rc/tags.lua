-- Tags

local shifty = loadrc("shifty", "vbe/shifty")
local keydoc = loadrc("keydoc", "vbe/keydoc")

local tagicon = function(icon)
   if screen.count() > 1 then
      return beautiful.icons .. "/taglist/" .. icon .. ".png"
   end
   return nil
end

shifty.config.tags = {
   irc = {
      init = true,
      position = 1,
      mwfact = 0.2,
      exclusive = true,
      screen = 1,
      icon = tagicon("im"),
   },
   dev = {
      init = true,
      position = 2,
      layout = awful.layout.suit.floating,
      exclusive = false,
      screen = screen.count(),
      -- spawn = "evilvte",
      icon = tagicon("dev"),
   },
   www = {
      position = 3,
      mwfact = 0.7,
      exclusive = true,
      max_clients = 3,
      screen = screen.count(),
      -- spawn = config.browser,
      icon = tagicon("web")
   },
   mail = {
      -- init = true,
      position = 4,
      layout = awful.layout.suit.fair,
      exclusive = true,
      screen = screen.count(),
      -- spawn = config.mail,
      icon = tagicon("web"),
      -- nopopup = true,           -- don't give focus on creation
   },
   xterm = {
      position = 5,
      layout = awful.layout.suit.fair,
      exclusive = true,
      -- screen = math.max(screen.count(), 2),
      spawn = config.terminal,
      icon = tagicon("main"),
      nopopup = true,           -- don't give focus on creation
   },

   movies = {
      position = 8,
      layout = awful.layout.suit.fair,
      screen = 1,
      icon = tagicon("main"),
      screen = screen.count(),
   },

   music = {
      -- init = true,
      position = 9,
      layout = awful.layout.suit.fair,
      exclusive = true,
      screen = 1,
      icon = tagicon("main"),
      -- spawn = "spotify",
      -- nopopup = true,           -- don't give focus on creation
   },
}

-- Also, see rules.lua
shifty.config.apps = {
   {
      match = { role = { "browser" }, },
      tag = "www",
   },
   {
      match = { "emacs", },
      tag = "dev",
      float = true
   },
   {
      match = { "spotify" },
      tag = "music",
   },

   {
      match = {
         "/home/jocke/Troglobit",
         "/home/jocke/Westermo"
      },
      tag = "dev",
      float = true
   },

   {
      match = {
         "byobu",
         "jocke@irc",
         "x-terminal-emulator"
      },
      tag = "irc",
      startup = {
         tag = "irc",
      },
      float = true
   },

   {
      match = {
         "Thunderbird",
         "Mail",
      },
      tag = "mail",
      float = true
   },
   {
      match = {
         "Transmission",
         "vlc"
      },
      tag = "movies",
      float = true,
   },
   {
      match = { class = { "Key[-]mon" },
                role = { "pop[-]up" },
                name = { "Firebug" },
                check = function (c)
                   return awful.rules.match(c,
                                            { instance = "chromium",
                                              class = "Chromium",
                                              name = "Chromium",
                                              fullscreen = true })
                end,
                instance = { "plugin[-]container", "exe" } },
      intrusive = true,
   },
}

shifty.config.defaults = {
   layout = config.layouts[1],
   mwfact = 0.6,
   ncol = 1,
   sweep_delay = 1,
}

shifty.taglist = config.taglist -- Set in widget.lua
shifty.init()

config.keys.global = awful.util.table.join(
   config.keys.global,
   keydoc.group("Tag management"),
   awful.key({ modkey }, "Tab", awful.tag.history.restore, "Switch to previous tag"),
   awful.key({ modkey }, "Left", awful.tag.viewprev),
   awful.key({ modkey }, "Right", awful.tag.viewnext),
   awful.key({ modkey, "Shift"}, "o",
             function()
                if screen.count() == 1 then return nil end
                local t = awful.tag.selected()
                local s = awful.util.cycle(screen.count(), t.screen + 1)
                awful.tag.history.restore()
                t = shifty.tagtoscr(s, t)
                awful.tag.viewonly(t)
             end,
             "Send tag to next screen"),
   awful.key({ modkey, "Control", "Shift"}, "o",
             function()
                if screen.count() == 1 then return nil end
                local t = awful.tag.selected()
                local o = t.screen
                local s = awful.util.cycle(screen.count(), o + 1)
                for _, t in pairs(screen[o]:tags()) do
                   shifty.tagtoscr(s, t)
                end
             end,
             "Send all tags to next screen"),
   awful.key({ modkey }, 0, shifty.add, "Create a new tag"),
   awful.key({ modkey, "Shift" }, 0, shifty.del, "Delete tag"),
   awful.key({ modkey, "Control" }, 0, shifty.rename, "Rename tag"))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, (shifty.config.maxtags or 9) do
   config.keys.global = awful.util.table.join(
      config.keys.global,
      keydoc.group("Tag management"),
      awful.key({ modkey }, i,
                function ()
                   local t = shifty.getpos(i)
                   local s = t.screen
                   local c = awful.client.focus.history.get(s, 0)
                   awful.tag.viewonly(t)
                   mouse.screen = s
                   if c then client.focus = c end
                end,
                i == 5 and "Display only this tag" or nil),
      awful.key({ modkey, "Control" }, i,
                function ()
                   local t = shifty.getpos(i)
                   t.selected = not t.selected
                end,
                i == 5 and "Toggle display of this tag" or nil),
      awful.key({ modkey, "Shift" }, i,
                function ()
                   local c = client.focus
                   if c then
                      local t = shifty.getpos(i, {nospawn = true })
                      awful.client.movetotag(t, c)
                   end
                end,
                i == 5 and "Move window to this tag" or nil),
      awful.key({ modkey, "Control", "Shift" }, i,
                function ()
                   if client.focus then
                      awful.client.toggletag(shifty.getpos(i, {nospawn = true}))
                   end
                end,
                i == 5 and "Toggle this tag on this window" or nil),
      keydoc.group("Misc"))
end
