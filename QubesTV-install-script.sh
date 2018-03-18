#!/bin/sh

# Author:
# Aekez @ github

# Disclaimer:
# !!!Warning!!! - Work in progress, not finished.

# Yes, I undetstand - introduction message.
zenity --width="420" --height="200" --title="Welcome to the QubesTV installer" --info --text='\nQubesTV is an unofficial project, and is not associated with The Qubes OS Project or Invisible Things Lab.\n\nWhile the author here seeks to provide best possible quality, it is important to remind you to use with QubesTV-alpha with caution. The author takes no responsibility for any outcome from using QubesTV.\n\nQubesTV is currently in alpha-state and is therefore still under heavy development change and restructuring.\n' --ok-label="Yes, I understand."


# Picking install approach, swift or detailed.
ans=$(zenity --width="420" --height="200" --title="Install approach" --question --text='Please pick an install approach. If you are already familiar with the script, then swift install may be recommended.\n\nHowever it is recommended to click no if you need advanced setup choices, or if you just prefer to be informed step-by-step what the script is doing during the install.\n\nNote!! Currently clicking yes will do the same as clicking no.\n' --ok-label="Yes, swift install" --cancel-label="No, show me what is being done" 2> /dev/null
if [ $? = 0 ] ; then
command=$(xterm -e '')
else
command=$()
fi
)
wait



# Dom0 dependency install.
ans=$(zenity --width="420" --height="200" --title="Dependency install" --question --text='\nIn order for sound-control to work properly, installing pulseaudio-utils is required in dom0, which is a dependency needed for the pactl command.\n\n- No further depencies are installed, it is a single package from the official fedora repository.\n\n- This package has been confirmed safe in dom0.\n' --ok-label="Yes, install dom0 dependency" --cancel-label="No, skip dom0 dependency install" 2> /dev/null
if [ $? = 0 ] ; then
command=$(xterm -e 'qubes-dom0-update pulseaudio-utils -y')
else
command=$()
fi
)
wait


# Adding QubesTV repository & downloading the scripts.
ans=$(zenity --width="420" --height="200" --title="Adding QubesTV repository & downloading the scripts." --question --text='\nPressing yes will add the repository required to install/update QubesTV and download QubesTV, nothing will be installed until next step.\n\n- QubesTV will be using the official Qubes OS approach to secure dom0/TemplateVM package install/updates.\n\n- In the future we will be looking into the possibility of moving QubesTV installer process away from dom0.\n\n- QubesTV may periodiocally be updated, keep the repository enabled if you want to receive updates. You may disable it at this /path.\n' --ok-label="Yes, prepare to install QubesTV" --cancel-label="No, stop installing QubesTV" 2> /dev/null
if [ $? = 0 ] ; then
command=$(xterm -e '')
else
command=$(sudo pkill -F '$HOME/QubesTV-install-script.pid')
fi
)
wait


# Cloning TemplateVM & creating QubesTV AppVM.
ans=$(zenity --width="420" --height="200" --title="Cloning TemplateVM & creating QubesTV AppVM" --question --text='\nThis step will clone and create the TemplateVM where codecs will be installed, and create the AppVM, QubesTV, where your browser modifications will be configured.\n\nRemember cloning a template will consume several GB drive space, and will take a while to complete, depending on how fast your system is.\n\nPlease modify the script if you dont have fedora-26 installed, however please use a fedora template to fully install QubesTV.\n' --ok-label="Yes, please setup QubesTV VMs" --cancel-label="No, I will do this manually" 2> /dev/null
if [ $? = 0 ] ; then
command=$(xterm -e 'qvm-clone fedora-26 fedora-26-QubesTV && qvm-create --property=name=QubesTV --property=template=fedora-26-QubesTV --class AppVM --label black')
else
command=$()
fi
)
wait




# Adding RPMFusion repositories and codecs.
ans=$(zenity --width="420" --height="200" --title="Installing template codecs dependencies" --question --text='\nThis step will install the codec dependcies required for Firefox.\n\nNote that both Google-Chrome & Chromium have their codecs build-in directly, while Firefox get its codecs externally from upstream repositories.\n\nAdding RPMFusion repositories is required and will be added in the TemplateVM in order to install the required codecs.' --ok-label="Yes, install codecs" --cancel-label="No, I will do this manually" 2> /dev/null
if [ $? = 0 ] ; then
command=$(xterm -e '')
else
command=$()
fi
)
wait


# Installing binary Google-Chrome for backup redundancy.
ans=$(zenity --width="420" --height="200" --title="Installing template dependencies" --question --text='\nUsing free and open-source software is encouraged, sometimes closed-binary code works better due to market lock-in.\n\nWhile Firefox can play most things, Google-Chrome is one such example where some protected-content sometimes may be eaiser played.\n\nQubesTV considers Google-Chrome as a backup solution, but uses Firefox as primary browser to stream content.\n\nClicking yes will add the official Google-Repository in the TemplateVM.' --ok-label="Yes, install Google-Chrome" --cancel-label="No, I will do this manually" 2> /dev/null
if [ $? = 0 ] ; then
command=$(xterm -e '')
else
command=$()
fi
)
wait



zenity --width="420" --height="200" --title="QubesTV install-finish" --info --text='\nThe QubesTV install script has reached its conclusion, and if everything went well, you should now have a working QubesTV.\n\nYou may still need to configure your keybinds, as well as adding your stream channels.\n\nQubesTV is not done yet, more work is required before it is considered ready for reviews and consumption.' --ok-label="Gotcha, I understand."

