#!/bin/bash

ANCHOR="${HOME}/.personal"

# ln -fs ${ANCHOR} `pwd` 

rm -f ~/.gitconfig && ln -vs ${ANCHOR}/git/gitconfig ~/.gitconfig
rm -f ~/.gitignore_global && ln -vs ${ANCHOR}/git/gitignore_global ~/.gitignore_global

if grep -q ${ANCHOR} ~/.bashrc ; then 
	echo 'bashrc already installed'; 
else
	echo "installing bashrc" 
	mv ~/.bashrc ~/.bashrc_temp
	echo ". ${ANCHOR}/bashrc.sh" > ~/.bashrc
	cat ~/.bashrc_temp >> ~/.bashrc
	rm ~/.bashrc_temp
fi

# install sbtconfig
rm -f ~/.sbtconfig && ln -vs ${ANCHOR}/sbtconfig ~/.sbtconfig

# install inputrc
rm -f ~/.inputrc && ln -vs ${ANCHOR}/inputrc ~/.inputrc

# install vim folder
rm -f ~/.vim && ln -vs ${ANCHOR}/vim ~/.vim

# install workflows
sudo rm -rf ~/Library/Services
ln -vs "${ANCHOR}/mac_os_x/workflow" ~/Library/Services

# install git submodules
git submodule foreach git pull

# http://dbknickerbocker.blogspot.com/2013/04/simple-fix-to-missing-toolsjar-in-jdk.html
# Cobertura could not find tools.jar on Mac OS X
if [[ $platform == 'macosx' ]]; then
	sudo ln -s /Library/Java/JavaVirtualMachines/1.6.0_65-b14-462.jdk/Contents/Classes/classes.jar /Library/Java/JavaVirtualMachines/1.6.0_65-b14-462.jdk/Contents/Classes/tools.jar
	sudo ln -s /Library/Java/JavaVirtualMachines/1.6.0_65-b14-462.jdk/Contents/Classes /Library/Java/JavaVirtualMachines/1.6.0_65-b14-462.jdk/Contents/lib
	sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/sbin/airport
fi

# install textmate properties
ln -vs ~/.personal/mac_os_x/textmate/tm_properties ~/.tm_properties
ln -s ~/.personal/mac_os_x/textmate/tm_properties ~/.tm_properties
