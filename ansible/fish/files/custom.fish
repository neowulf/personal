# Enable fish bindings
fish_vi_key_bindings

# Conda files
source /Users/siva.kommuri/.local/share/omf/themes/sushi/fish_right_prompt.fish
source /usr/local/anaconda/etc/fish/conf.d/conda.fish

conda activate base

set -gx PATH /usr/local/opt/mysql-client/bin $PATH

set -gx GOPATH $HOME/go 

set -gx PATH $GOPATH/bin $PATH
alias go colorgo

set -gx LESS "-XgmR"

