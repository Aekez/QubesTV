# QubesTV - ALPHA
SmartTV's are growing increasingly insecure as we speak. This project is taking back control of your insecure microphone, video-cam, A.I. enabled TV, with a secure smartTV, which we're calling QubesTV. Currently QubesTV is being developed, however some scripts can be used already if you implement them yourself. Features are improved over time, stay tuned.

### Disclaimer ###
Please note that QubesTV has not yet reached beta state, and should not be used unless you know what you're getting yourself into.

## 1. Purpose of this page
This page serves a double function as to explaining the details of the inner-workings of QubesTV during it's alpha/beta phases, as well as a way to see which features are planned or finished. This page is a work-in-progress model, and not everything finished has been uploaded here yet, neither is anything shown here considered finished before release version 1.0 either. QubesTV will be perfected and improved in further future 1.x versions.

***

## 2. Essential Dependencies
Currently QubesTV is based on a single dom0 dependency PulseAudio-utils (pactl command) to control the sound. Note that this particular package from the official fedora repositories has been confirmed safe to install in dom0. It is normally discouraged to install anything in dom0, but Qubes isn't fully ready to completely lock down dom0. For those of you who are new to Qubes, be careful not to make this a habit, a core principle of Qubes is to keep dom0 as locked down as far possible, however an exception can be made for reliable packages which are trustworthy, and that it makes sense to add it to dom0. In order to control sound in dom0, this package is needed, therefore you must install it to use any of the pactl commands below. 

```ruby
[user@dom0 ~]$ sudo qubes-dom0-update pulseaudio-utils
```


***

## 3. Streaming - Channel control

### 3.1. Channel selector 
Once the issue has been sorted here, 3.1. and 3.2. will hopefully be merged together. Meanwhile, you can use this to start up a Qube with a TV stream. It's not perfect, please use 3.2. for proper reliability until this gets fixed. 
```ruby
#!/bin/sh
qvm-start QubesTV
wait 
sleep 5 #important to use wait/sleep combination. Slower CPU warrants longer sleep (need fix).
qvm-run QubesTV 'xterm -e firefox https://www.address.web/stream/etc.'
```

### 3.2. Change active Stream in AppVM with new channel
Try this beautiful, couple of minutes long, stunning footage of our planet. It can be executed from dom0 into an AppVM. Currently this command "bash" only works if there is an existing Firefox running inside the AppVM. This will eventually get fixed.
```ruby
#!/bin/sh
qvm-run QubesTV 'bash -e firefox https://www.youtube.com/watch?v=ChOhcHD8fBA&feature=youtu.be&t=68'
```
YouTube channel and credits: IslandiaME

***

## 4. Window management scripts
Remember you can create variations of these examples, be creative if you got special unique needs. There are multiple of ways to put these together. Consult the terminal manual `'man wmctrl'` for further controls.
### 4.1. Toggle, full-screen of a specific AppVM Window
Remember to change Mozilla Firefox to whatever is in your windows title panel, it must be a title that stays the same over time.
```ruby
#!/bin/sh
wid=$(xdotool search --name 'Mozilla Firefox')
wmctrl -i -r $wid -b toggle,fullscreen
```
### 4.2. Active, full-screen of any current active window
This script, if keybinded, can perform the exact same functionality that alt+space+f (or right clicking on Qubes window panels and click full-screen) does. The usefulness is that you can now modify your own shortcut keys to fullscreen, which is especially handy for a QubesTV without a keyboard prepared on the table.
```ruby
#!/bin/sh
wmctrl -r :ACTIVE: -b toggle,fullscreen
```

### 4.3. Select, maximize/unmaximize window - Target window to trigger with your mouse
Add, remove, toggle, functionalities are here highlighted. You can mix these with other `wmctrl -b` option configurations.
```ruby
#!/bin/sh
wmctrl -r :SELECT: -b add,maximized_vert,maximized_horz
```
```ruby
#!/bin/sh
wmctrl -r :SELECT: -b remove,maximized_vert,maximized_horz
```
```ruby
#!/bin/sh
wmctrl -r :SELECT: -b toggle,maximized_vert,maximized_horz
```
### 4.4. Active, unmaximize window
```ruby
#!/bin/sh
wmctrl -r :ACTIVE: -b toggle,maximized_vert,maximized_horz
```
***


## 5. Sound control scripts
This covers from full system sound control, down to how to control specific AppVM sound control, either utilized by keybinds or scripts. 
### 5.1. Toggle mute, affects the entire Qubes sound from sink 0.

```ruby
#!/bin/sh
pactl set-sink-input-mute 0 toggle
```


### 5.2. Volume control
Caution, try not to cause a sound explosion of sudden loud volume by accident. Think carefully when using volume control. Safety mechanics might be implemented in the future if possible.

Caution, it can exceed 100% which may give a poor sound experience, harm your speakers, or worse causing hearing damage to your eardrums. Don't use them recklessly.

Volume up by 20% on sink 0. 
```ruby
#!/bin/sh
pactl set-sink-volume 0 +20%
```
Volume down by 20% on sink 0.
```ruby
#!/bin/sh
pactl set-sink-volume 0 -20%
```
Instantly set volume at 100% or any preferred value. 
```ruby
#!/bin/sh
pactl set-sink-volume 0 100%
```

***

## 6. Secure offline Voice control of QubesTV
Open Source - Voice Control, https://mycroft.ai/
More to come soon.

YouTube link will take you off github, i.e. right click and open in tab instead if needed.
[![](https://img.youtube.com/vi/jUJbPR6YXFE/0.jpg)](https://www.youtube.com/watch?v=jUJbPR6YXFE&feature=youtu.be&t=41)



***

## 7. Single click scripts to move Stream windows/sound between screens (testing script, will be changed)
```ruby
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
```



***

## 8. Automatic start-up scripts
```ruby
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
```


***

## 9. Creating secure icons for your QubesTV channels

### Step 1. Search for icons 

### Step 2. Identity licenses and fair-use

### Step 3. Move to secure and clean offline AppVM, and clean the icons from potential exploits

### Step 4. Move the cleaned icons to dom0

### Step 5. Taking precautions in the future (security aspect)


***

## 10. Creating your QubesTV remote 

### 10.1. Numpad Remote

<img src="https://images-na.ssl-images-amazon.com/images/I/61g0iGF%2B--L._SL1000_.jpg" data-canonical-src="" width="200" height="200" />

Picture is credited to Amazon, seller SimpFun. Disclaimer: This is not a buying recommendation, this particular product has not been tested. However, it should give you an idea of what to aim for between the remote possibilities. Furthermore ownership of this pictures goes to Amazon and the selling company.

### 10.2. PC-TV Remote 

<img src="https://images-na.ssl-images-amazon.com/images/I/61RP3%2BeKlNL._SL1000_.jpg" data-canonical-src="" width="200" height="200" />

<img src="https://images-na.ssl-images-amazon.com/images/I/61qepFuuH%2BL._SL1000_.jpg" data-canonical-src="" width="200" height="200" />

<img src="https://images-na.ssl-images-amazon.com/images/I/71DLX8bb%2BNL._SL1500_.jpg" data-canonical-src="" width="200" height="200" />

Pictures is credited to Amazon, seller V VONTAR, FeBite, ProChosen, in that order from left to right. Disclaimer: This is not a buying recommendation, these particular product has not been tested. However, it should give you an idea of what to aim for between the remote possibilities. Furthermore ownership of these pictures goes to Amazon and the selling companies.

In addition, only numpads have has been tested with the QubesTV, TV-PC remotes are currently in general untested as a category solution.

***

## 11. Codec's and video compatibility


### 11.1 Upstream Fedora codec's and compatibility (Firefox)

### 11.2. Upstream Debian codec's and compatibility (Firefox)

### 11.3. Upstream Whonix-WS codec's and compatibility (TOR)

### 11.4. Quick solution that mostly tends to work, at a privacy cost (Google Chrome)

***

## 12. QubesTV installer
Currently this is planned for last, it may be implemented in a later QubesTV version. 

***
