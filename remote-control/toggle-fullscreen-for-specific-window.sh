#!/bin/sh
wid=$(xdotool search --name 'Mozilla Firefox')
wmctrl -i -r $wid -b toggle,fullscreen
