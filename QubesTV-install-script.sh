#!/bin/sh

# Author:
# Aekez @ github

# Disclaimer:
# !!!Warning!!! - Work in progress, not finished.

# !>>> Install instructions <<<!
# In order to safely install QubesTV, which in its current version must be installed in dom0,
# you will need to manually transfer the scripts to dom0, specially at /home/user/QubesTV.
# In order to install QubesTV, you will need to execute this script, at above location, while
# keeping the integrity of the QubesTV folders content together. If you need to find the QubesTV
# repository, it can be found here on GitHub: https://github.com/Qubes-Community/QubesTV
# In order to protect dom0, no repositories will be added in dom0. Hopefully it will be possible
# to make QubesTV work outside dom0 in the future, but for now this is a needed step.
# Only one safe dom0 depency package will be installed in dom0, the remaining installs will be done
# inside templates and AppVMs.




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


# Cloning TemplateVM & creating QubesTV AppVM.
ans=$(zenity --width="420" --height="200" --title="Cloning TemplateVM & creating QubesTV AppVM" --question --text='\nThis step will clone and create the TemplateVM where codecs will be installed, and create the AppVM, QubesTV, where your browser modifications will be configured.\n\nRemember cloning a template will consume several GB drive space, and will take a while to complete, depending on how fast your system is.\n\nPlease modify the script if you dont have fedora-26 installed, however please use a fedora template to fully install QubesTV.\n' --ok-label="Yes, please setup QubesTV VMs" --cancel-label="No, I will do this manually" 2> /dev/null
if [ $? = 0 ] ; then
command=$(xterm -e 'qvm-clone fedora-26 fedora-26-QubesTV && qvm-create --property=name=QubesTV --property=template=fedora-26-QubesTV --class AppVM --label black')
else
command=$()
fi
)
wait




# Adding TemplateVM RPMFusion repositories and codecs.
ans=$(zenity --width="420" --height="200" --title="Installing template codecs dependencies" --question --text='\nThis step will install the codec dependcies required for Firefox.\n\nNote that both Google-Chrome & Chromium have their codecs build-in directly, while Firefox get its codecs externally from upstream repositories.\n\nAdding RPMFusion repositories is required and will be added in the TemplateVM in order to install the required codecs.' --ok-label="Yes, install codecs" --cancel-label="No, I will do this manually" 2> /dev/null
if [ $? = 0 ] ; then
command=$(xterm -e '')
else
command=$()
fi
)
wait


# Installing TemplateVM Google-Chrome for backup redundancy.
ans=$(zenity --width="420" --height="200" --title="Installing template dependencies" --question --text='\nUsing free and open-source software is encouraged, sometimes closed-binary code works better due to market lock-in.\n\nWhile Firefox can play most things, Google-Chrome is one such example where some protected-content sometimes may be eaiser played.\n\nQubesTV considers Google-Chrome as a backup solution, but uses Firefox as primary browser to stream content.\n\nClicking yes will add the official Google-Repository in the TemplateVM.' --ok-label="Yes, install Google-Chrome" --cancel-label="No, I will do this manually" 2> /dev/null
if [ $? = 0 ] ; then
command=$(xterm -e '')
else
command=$()
fi
)
wait



zenity --width="420" --height="200" --title="QubesTV install-finish" --info --text='\nThe QubesTV install script has reached its conclusion, and if everything went well, you should now have a working QubesTV.\n\nYou may still need to configure your keybinds, as well as adding your stream channels.\n\nQubesTV is not done yet, more work is required before it is considered ready for reviews and consumption.' --ok-label="Gotcha, I understand."

