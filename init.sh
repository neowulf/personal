#!/bin/bash

ANCHOR="${HOME}/.personal"

# ln -fs ${ANCHOR} `pwd` 

if grep -q ${ANCHOR} ~/.bashrc ; then
	echo 'bashrc already installed'; 
else
	echo "installing bashrc" 
	mv ~/.bashrc ~/.bashrc_temp
	echo ". ${ANCHOR}/bashrc/personal_bashrc.sh" > ~/.bashrc
	cat ~/.bashrc_temp >> ~/.bashrc
	rm ~/.bashrc_temp
	chmod +x ~/.bashrc
fi

# Install the configs directory
for i in ${ANCHOR}/configs/* ; do
    ln -vs -f $i ~/.$(echo ${i} | cut -d '/' -f 6);
done

# install workflows
sudo rm -rf ~/Library/Services
ln -vs "${ANCHOR}/mac_os_x/workflow" ~/Library/Services

# install git submodules
git submodule foreach git pull

# http://dbknickerbocker.blogspot.com/2013/04/simple-fix-to-missing-toolsjar-in-jdk.html
# Cobertura could not find tools.jar on Mac OS X
if [[ $platform == 'macosx' ]]; then
#	sudo ln -s /Library/Java/JavaVirtualMachines/1.6.0_65-b14-462.jdk/Contents/Classes/classes.jar /Library/Java/JavaVirtualMachines/1.6.0_65-b14-462.jdk/Contents/Classes/tools.jar
#	sudo ln -s /Library/Java/JavaVirtualMachines/1.6.0_65-b14-462.jdk/Contents/Classes /Library/Java/JavaVirtualMachines/1.6.0_65-b14-462.jdk/Contents/lib
	sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/sbin/airport
fi

~/.config> ln -s ~/.personal/shell/fish .
ln -vs "${ANCHOR}/shell/fish ~/.config/fish"

ln -vs "${ANCHOR}/mac_os_x/hydra ~/.hydra"
