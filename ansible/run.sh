#!/bin/bash

ansible-playbook -i 'localhost,' -c local playbook.yml

echo "Change the default shell in the User settigs in the System Preferences"
echo "`sudo chsh -s /usr/local/bin/fish $(whoami)`"

