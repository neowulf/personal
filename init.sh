#!/bin/bash

ANCHOR="~/.personal"

ln -fs `pwd` ${ANCHOR}

ln -fs ${ANCHOR}/git/gitconfig ~/.gitconfig
ln -fs ${ANCHOR}/git/gitignore_global ~/.gitignore_global

echo ". ${ANCHOR}/bashrc" >> ~/.bashrc

# install workflow
cp ${ANCHOR}/workflow/*.workflow ~/Library/Services/
