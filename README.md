My AwesomeWM config
===================

After cloning the repo, update the GIT submodule

    git submodule update --init

After `git pull` remember to `git submodule update --recursive`


Tools
-----

You may benefit from installing the following external tools:

- xrandr
- xautolock
- xcompmgr
- xscreensaver
- [xplugd][]
- [light][]
- nm-applet
- blueman
- pasystray
- scrot
- feh


Setup
-----

One of the most frequently asked questions are; _"How do I set up
Awesome with a dark theme?".  Here are two answers that might work:

 - lxappearance
 - gsettings

The following worked for me, and is what's encoded in `rc.lua`

```sh
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.wm.preferences theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface icon-theme "Adwaita-dark"
```

[xplugd]: https://github.com/troglobit/xplugd
[light]:  https://github.com/haikarainen/light
