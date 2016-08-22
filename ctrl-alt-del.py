#!/usr/bin/env python

import pygtk
pygtk.require('2.0')
import gtk
import os

if __name__ == "__main__":
    dialog = gtk.MessageDialog(type=gtk.MESSAGE_WARNING)
    dialog.set_position(1)
    dialog.set_markup("<big><b>Shutdown computer now?</b></big>")
    dialog.add_button("Log Out", 0)
    dialog.add_button("Sleep", 1)
    dialog.add_button("Restart", 2)
    dialog.add_button("Shut Down", 3)
    action = dialog.run()
    if action == 0:
        os.system("echo 'awesome.quit()' | awesome-client -");
    elif action == 1:
        os.system("systemctl suspend");
    elif action == 2:
        os.system("systemctl reboot");
    elif action == 3:
        os.system("systemctl poweroff");

    exit(0)
