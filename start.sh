#!/bin/bash

STREAM_DISPLAY=:1.0
STREAM_LEFT=100
STREAM_TOP=73
STREAM_WIDTH=1280
STREAM_HEIGHT=720

# Start up a Xephyr virtual desktop dedicated to display
#Xephyr ${STREAM_DISPLAY} -host-cursor -screen ${STREAM_WIDTH}x${STREAM_HEIGHT}x16 -dpi 96 -ac -extension Composite &
Xephyr ${STREAM_DISPLAY} -host-cursor -name streamdisplay -screen ${STREAM_WIDTH}x${STREAM_HEIGHT}x16 -ac &

# For now, just move the Xephyr display to a fixed position on the desktop
# We can easily set vlc to capture this seciton, but in the future we should
# capture the window via x11 and pipe to vlc
#xdotool

sleep 1

#move the Xephyr display to a known place on our desktop
wmctrl -x -R streamdisplay.Xephyr -e 1,${STREAM_LEFT},${STREAM_TOP},${STREAM_WIDTH},${STREAM_HEIGHT}

sleep 1

# Start up our custom Tiling Window Manager on the virtual desktop
# This allows us to control stream and video window layouts "easily"
#DISPLAY=${STREAM_DISPLAY} nwm --xephyr -glamor &
DISPLAY=${STREAM_DISPLAY} nwm --xephyr &

# Oddly we have to wait for
#sleep 1


#DISPLAY=${STREAM_DISPLAY} gnome-terminal -x sh -c 'top; exec bash' &

#DISPLAY=${STREAM_DISPLAY} gnome-terminal -x sh -c 'vim; exec bash' &

#DISPLAY=${STREAM_DISPLAY} gnome-terminal -x sh -c 'irssi; exec bash' &

#DISPLAY=${STREAM_DISPLAY} google-chrome http://boards.4chan.org/tv/ &
