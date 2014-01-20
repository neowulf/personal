#!/bin/bash

ANCHOR="~/.personal"

ln -fs ${ANCHOR} `pwd` 

ln -fs ${ANCHOR}/git/gitconfig ~/.gitconfig
ln -fs ${ANCHOR}/git/gitignore_global ~/.gitignore_global

if grep -q .personal ~/.bashrc ; then 
	echo 'bashrc already installed'; 
else
	echo "installing bashrc" 
	mv ~/.bashrc ~/.bashrc_temp
	echo ". ${ANCHOR}/bashrc" > ~/.bashrc
	cat ~/.bashrc_temp >> ~/.bashrc
	rm ~/.bashrc_temp
fi

# install workflows
sudo rm -rf ~/Library/Services
ln -fs "${ANCHOR}/mac_os_x/workflow" ~/Library/Services