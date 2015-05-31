The awesome Troglobit configuration
===================================

This is my personal reworked and slightly generalized fork of
[Vincent Bernat's configuration] of the [awesome window manager].

The following is a cut down version of Vincent's original comments,
rewritten to the third person.

----

This configuration is for _awesome_ 3.4, it's not updated for 3.5 yet.

Some parts of the configuration rely on the machine hostname, see the
file `rc/start.lua` for details.

Here some of the things you may be interested in:

 - The configuration is modular.  The variable `config` is used as a
   table to pass different things between "modules".

 - In `rc/xrun.lua`, there is a `xrun` function which runs a program
   only if it is not already running.  Instead of relying on tools like
   `ps`, it looks at the list of awesome clients and at the list of
   connected clients with `xwininfo`. Seems reliable.

 - A light transparency effect is used to tell if a window has the focus
   or not.  It needs a composite manager.

 - A Python script `bin/build-wallpaper` is used to build the wallpaper
   to be displayed.  There is a random selection and it works with
   multihead setup.

 - `xss-lock` with `i3lock` is used as a screensaver.  It relies on
   standard X screensaver handling (and therefore is easy for
   application to disable) and also supports systemd inhibitors.  A
   notification is sent 10 seconds before starting.

 - The file `rc/apparance.lua` is responsible to give GTK2 and GTK3 a
   unified look.  It works and does not need `gnome-control-center`.

 - Vincent implemented notifications when changing volume or brightness.
   This is also used when changing xrandr setup.  It is pretty cool!
 
 - Keybindings are "autodocumented". See `lib/keydoc.lua` to see how
   this works. The list of key bindings can be accessed with Mod4 + F1.
   
Things in `lib/` are meant to be reused.  A local `loadrc()` function is
used to load modules.  Vincent's modules are prefixed with `vbe/`.
Before reusing a module, you may want to change this. Another way to
load them is to use:

	require("lib/quake")
	local quake = package.loaded["vbe/quake"]

[awesome window manager]: http://awesome.naquadah.org
[Vincent Bernat's configuration]: https://github.com/vincentbernat/awesome-configuration

<!--
  -- Local Variables:
  -- mode: markdown
  -- End:
  -->
