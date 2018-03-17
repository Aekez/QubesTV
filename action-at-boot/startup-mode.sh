#!/bin/sh
qvm-start QubesTV
wait
qvm-run -q -a --service -- QubesTV qubes.StartApp+firefox
wait
( sleep 5 )
wid=$(xdotool search --name 'Mozilla Firefox')
( sleep 0,2 )
wmctrl -i -r $wid -e 0,0,0,1800,900
( sleep 1 )
wmctrl -i -r $wid -b add,fullscreen
