# Path to Oh My Fish install.
set -gx OMF_PATH "/Users/siva/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/Users/siva/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

source ~/.personal/bashrc/bash_aliases.sh

source ~/.config/fish/functions/fish_preexec.fish

#date
#echo 'starting rvm'
#source ~/.config/fish/functions/rvm.fish
#rvm default &
#rvm default > /dev/null 2>&1 &
#echo 'ending rvm'
#date

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/siva/Documents/lg/code/whiteboard/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/siva/Documents/lg/code/whiteboard/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/siva/Documents/lg/code/whiteboard/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /Users/siva/Documents/lg/code/whiteboard/serverless/node_modules/tabtab/.completions/sls.fish

# source (conda info --root)/etc/fish/conf.d/conda.fish 
source /usr/local/miniconda2/etc/fish/conf.d/conda.fish 

fish_vi_key_bindings
