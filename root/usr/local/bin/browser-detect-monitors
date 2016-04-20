#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
    Detect Screens
    Copyright (C) 2016 Thomaz de Oliveira dos Reis <thor27@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

from __future__ import print_function
import gtk
import sys
import argparse

try:
    from urllib.parse import urlparse
except ImportError:
    from urlparse import urlparse


class Kiosk(object):
    __NUM_KIOSKS = 0

    @staticmethod
    def push_kiosk():
        Kiosk.__NUM_KIOSKS += 1
        return Kiosk.__NUM_KIOSKS

    @staticmethod
    def pop_kiosk():
        Kiosk.__NUM_KIOSKS -= 1
        return Kiosk.__NUM_KIOSKS

    def __init__(self, monitor, disable_close=True, text="Hello World"):
        self.disable_close = disable_close
        self.text = text

        self.create_window()
        self.move_to_monitor(monitor)
        self.fullscreen()
        Kiosk.push_kiosk()

    def create_window(self):
        self.window = gtk.Window()
        self.screen = self.window.get_screen()
        self.label = gtk.Label()
        self.label.set_markup("<span weight='bold' size='100000'>{0}</span>".format(self.text))
        self.label.set_alignment(xalign=0.05, yalign=0.05)
        self.window.add(self.label)
        self.window.connect("delete-event", self.on_close)
        self.window.show_all()

    def fullscreen(self):
        self.window.fullscreen()
        self.window.show_all()
        self.window.set_resizable(False)

    def move_to_monitor(self, id):
        monitor = self.screen.get_monitor_geometry(id)
        self.window.move(monitor.x, monitor.y)
        self.window.set_size_request(monitor.width, monitor.height)

    def on_close(self, *args, **kwargs):
        if self.disable_close:
            return True

        if not Kiosk.pop_kiosk():
            gtk.main_quit()


def get_text(parent, message, default=''):
    """
    Display a dialog with a text entry.
    Returns the text, or None if canceled.
    """
    d = gtk.MessageDialog(parent,
                          gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
                          gtk.MESSAGE_QUESTION,
                          gtk.BUTTONS_OK_CANCEL,
                          message)
    entry = gtk.Entry()
    entry.set_text(default)
    entry.show()

    def filter_numbers(entry, *args):
            text = entry.get_text().strip()
            entry.set_text(''.join([i for i in text if i.isdigit()]))

    entry.connect('changed', filter_numbers)
    d.vbox.pack_end(entry)
    entry.connect('activate', lambda _: d.response(gtk.RESPONSE_OK))
    d.set_default_response(gtk.RESPONSE_OK)

    r = d.run()
    text = entry.get_text().decode('utf8')
    d.destroy()
    if r == gtk.RESPONSE_OK:
        return text
    else:
        return None


def parse_args(args):
    parser = argparse.ArgumentParser(description='Detect screens')
    parser.add_argument('urls', metavar='URL', type=str, nargs='+',
                        help='All urls you want to show')
    parser.add_argument('-m', '--messages', type=str, nargs='+', dest='messages',
                        help='Text of each message to ask for monitor URL')
    parser.add_argument('-d', '--default-url', type=str, dest='default_url', default='about:blank',
                        help='Default URL to use (Default: about:blank)')
    parser.add_argument('-c', '--allow-close', dest='disable_close', action='store_false',
                        help='Allow browser window to be closed')

    return parser.parse_args(args)


def get_num_monitors():
    screen = gtk.gdk.Screen()
    return screen.get_n_monitors()


def main():
    args = parse_args(sys.argv[1:])

    num_monitors = get_num_monitors()

    for monitor in range(num_monitors):
        Kiosk(
            monitor,
            text="{0}".format(monitor),
            disable_close=args.disable_close,
        )

    result = [args.default_url for x in range(num_monitors)]

    for pos, url in enumerate(args.urls[:num_monitors]):
        message = args.messages[pos] if args.messages and pos < len(args.messages) else url
        while True:
            user_input = get_text(None, message)
            if user_input:
                monitor_number = int(user_input)
                if monitor_number < num_monitors and result[monitor_number] == args.default_url:
                    break
        result[monitor_number] = url

    return result

if __name__ == '__main__':
    print(" ".join(main()))
