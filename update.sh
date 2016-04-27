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
rm -rf root/opt/keyboard-websocket
cp -r ../keyboard-websocket root/opt
mkdir root/opt/keyboard-websocket/packages
pip install --download root/opt/keyboard-websocket/packages -r root/opt/keyboard-websocket/requirements.txt

#HACK FIX for GIT req
cp root/opt/keyboard-websocket/requirements.txt root/opt/keyboard-websocket/requirements.txt.original
cat root/opt/keyboard-websocket/requirements.txt.original | grep -v git > root/opt/keyboard-websocket/requirements.txt
echo 'socketIO-client==0.6.6' >> root/opt/keyboard-websocket/requirements.txt

cd root
tar -czf urna_extras.tar.gz *
mv urna_extras.tar.gz ../simple-cdd/profiles
cd ..
rm -rf src
