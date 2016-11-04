
xset s off         # don't activate screensaver
xset -dpms         # disable DPMS (Energy Star) features.
xset s noblank     # don't blank the video device

xfwm4 &
xbindkeys
sleep 0.5
start_monitors
sleep 0.5
start_browser
