# Enable fish bindings
fish_vi_key_bindings

# Windows Machine
# set -gx DOCKER_HOST localhost:2375

# Conda files
# source /Users/siva/.local/share/omf/themes/sushi/fish_right_prompt.fish
# source /usr/local/lib/anaconda3/etc/fish/conf.d/conda.fish
# conda activate base

set -g fish_user_paths "/usr/local/opt/libpq/bin" $fish_user_paths

set -gx GOPATH $HOME/go 
set -gx PATH $GOPATH/bin $PATH
set -gx PATH /usr/local/opt/grep/libexec/gnubin $PATH

#alias go colorgo

# set -gx JAVA_HOME (/usr/libexec/java_home)

set -gx LESS "-XgmR"
set -gx EDITOR "vim"
alias vi vim

# bobthefish - https://github.com/oh-my-fish/theme-bobthefish
# set -g theme_color_scheme gruvbox # iterm-theme gruvbox dark
# set -g theme_color_scheme solarized-light
set -g theme_color_scheme solarized-dark
set -g theme_display_k8s_context yes
set -g theme_display_k8s_namespace yes
#set -g theme_newline_cursor yes
set -g theme_display_git yes
set -g theme_nerd_fonts no
# set -g theme_display_virtualenv yes

# es - theme
set fish_command_timer_status_enabled 0

###################################

# https://stackoverflow.com/questions/4421633/who-is-listening-on-a-given-tcp-port-on-mac-os-x
function pport
  lsof -nP -iTCP:$argv | grep LISTEN
end

# https://direnv.net/docs/hook.html#fish
direnv hook fish | source
# https://github.com/direnv/direnv/wiki/Tmux
alias tmux "direnv exec / tmux"

# posix-source .env file to load the variables into the shell
function posix-source
    for i in (cat $argv)
        set arr (echo $i |tr = \n)
          set -gx $arr[1] $arr[2]
    end
end

##################################

source ~/.work/*.config.fish

function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end
