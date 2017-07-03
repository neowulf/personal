# Path to Oh My Fish install.
set -gx OMF_PATH "/Users/siva/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/Users/siva/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

source ~/.personal/bashrc/bash_aliases.sh

#set -x ANSIBLE_HOME '/usr/local/Cellar/ansible/2.1.0.0'
rvm default

source ~/.config/fish/functions/fish_preexec.fish
