#!/bin/bash

ANCHOR="~/.personal"

ln -fs ${ANCHOR} `pwd` 

ln -fs ${ANCHOR}/git/gitconfig ~/.gitconfig
ln -fs ${ANCHOR}/git/gitignore_global ~/.gitignore_global

echo ". ${ANCHOR}/bashrc" >> ~/.bashrc

# install workflow
# manually copy these directories from "${ANCHOR}/mac\ stuff/workflow/*.workflow" to ~/Library/Services
