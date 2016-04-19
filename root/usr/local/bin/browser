#!/usr/bin/env python
"""
    This is a fullscreen Webkit based browser for kiosks and displays, with multi-monitor support
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
import webkit
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

    def __init__(self, url, monitor, disable_close=True, allow_any_host=False, allowed_hosts=None):
        self.disable_close = disable_close
        self.allow_any_host = allow_any_host
        self.allowed_hosts = [urlparse(url).hostname]

        if allowed_hosts:
            self.allowed_hosts += allowed_hosts

        self.create_window()
        self.move_to_monitor(monitor)
        self.fullscreen()
        self.open_url(url)
        Kiosk.push_kiosk()

    def create_window(self):
        self.web = webkit.WebView()
        self.window = gtk.Window()
        self.screen = self.window.get_screen()
        self.scroll_container = gtk.ScrolledWindow()
        self.scroll_container.add(self.web)
        self.window.add(self.scroll_container)
        self.window.connect("delete-event", self.on_close)
        self.web.connect("navigation-policy-decision-requested", self.navigate)
        self.window.show_all()

    def fullscreen(self):
        self.window.fullscreen()
        self.window.set_resizable(False)

    def open_url(self, url):
        url = 'http://' + url if not '://' in url else url
        self.web.open(url)

    def move_to_monitor(self, id):
        monitor = self.screen.get_monitor_geometry(id)
        self.window.move(monitor.x, monitor.y)
        self.window.set_size_request(monitor.width, monitor.height)

    def on_close(self, *args, **kwargs):
        if self.disable_close:
            return True

        if not Kiosk.pop_kiosk():
            gtk.main_quit()

    def navigate(self, view, frame, request, action, decision):
        if self.allow_any_host:
            return
        uri = urlparse(request.get_uri())
        if uri.hostname not in self.allowed_hosts:
            print('{0} not allowed host. Allowed hosts are: {1}.'.format(uri.hostname, ", ".join(self.allowed_hosts)))
            decision.ignore()


def parse_args(args):
    parser = argparse.ArgumentParser(description='Open Kiosk browsers.')
    parser.add_argument('urls', metavar='URL', type=str, nargs='+',
                        help='One url for each available monitor')

    parser.add_argument('-c', '--allow-close', dest='disable_close', action='store_false',
                        help='Allow browser window to be closed')

    parser.add_argument('-y', '--allow-any-host', dest='allow_any_host', action='store_true',
                        help='Allow any hosts to be opened in the browser')

    parser.add_argument('-a', '--allowed-hosts', metavar='hostname', type=str, dest='allowed_hosts', nargs='*', default=None,
                        help='Extra allowed hosts to open in browser')
    return parser.parse_args(args)


def get_num_monitors():
    screen = gtk.gdk.Screen()
    return screen.get_n_monitors()


def main():
    args = parse_args(sys.argv[1:])

    num_monitors = get_num_monitors()

    for monitor, url in enumerate(args.urls[:num_monitors]):
        Kiosk(
            url,
            monitor,
            disable_close=args.disable_close,
            allow_any_host=args.allow_any_host,
            allowed_hosts=args.allowed_hosts
        )

    gtk.main()


if __name__ == '__main__':
    main()
