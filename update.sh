#!/bin/sh

if [ ! -f root/opt/VBoxLinuxAdditions.run ]
then
   echo "Copie o VBoxLinuxAdditions.run para root/opt antes de continuar..."
   exit 1
fi

cp ../multimonitor-browser/browser.py root/usr/local/bin/browser
chmod +x root/usr/local/bin/browser
cp ../multimonitor-browser/detect_monitors.py root/usr/local/bin/browser-detect-monitors
chmod +x root/usr/local/bin/browser-detect-monitors

cd root
tar -czf urna_extras.tar.gz *
mv urna_extras.tar.gz ../simple-cdd/profiles
