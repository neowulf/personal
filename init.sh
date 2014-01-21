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

# install workflows
sudo rm -rf ~/Library/Services
ln -vs "${ANCHOR}/mac_os_x/workflow" ~/Library/Services

# install git submodules
git submodule foreach git pull
