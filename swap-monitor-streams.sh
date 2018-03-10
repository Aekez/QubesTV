#!/bin/sh
wid=$(xdotool search --name 'Mozilla Firefox - Window-1')
wmctrl -i -r $wid -b remove,fullscreen
wait
wid=$(xdotool search --name 'Mozilla Firefox - Window-2')
wmctrl -i -r $wid -b remove,fullscreen
wait

wid=$(xdotool search --name 'Mozilla Firefox - Window-1')
wait
xdotool windowsize
wmctrl -i -r $wid -e 0,1925,0,1800,900
wait

wid=$(xdotool search --name 'Mozilla Firefox - Window-2')
wait
wmctrl -i -r $wid -e 0,0,0,1800,900
wait

wid=$(xdotool search --name 'Mozilla Firefox - Window-1')
wmctrl -i -r $wid -b add,fullscreen
wait
wid=$(xdotool search --name 'Mozilla Firefox - Window-2')
wmctrl -i -r $wid -b add,fullscreen
