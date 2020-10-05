# Enable fish bindings
# fish_vi_key_bindings

# Windows Machine
# set -gx DOCKER_HOST localhost:2375

# Conda files
# source /Users/siva/.local/share/omf/themes/sushi/fish_right_prompt.fish
# source /usr/local/lib/anaconda3/etc/fish/conf.d/conda.fish
# conda activate base

# set -gx PATH /usr/local/opt/mysql-client/bin $PATH
set -g fish_user_paths "/usr/local/opt/libpq/bin" $fish_user_paths

set -gx GOPATH $HOME/go 
set -gx PATH $GOPATH/bin $PATH

#alias go colorgo
alias git hub

# set -gx JAVA_HOME (/usr/libexec/java_home)

set -gx LESS "-XgmR"
set -gx EDITOR "vim"

# bobthefish - https://github.com/oh-my-fish/theme-bobthefish
# set -g theme_color_scheme gruvbox # iterm-theme gruvbox dark
# set -g theme_color_scheme solarized-light
set -g theme_color_scheme solarized-dark
set -g theme_display_k8s_context yes
set -g theme_display_k8s_namespace yes
set -g theme_newline_cursor yes
set -g theme_display_git yes
set -g theme_nerd_fonts no
# set -g theme_display_virtualenv yes

###################################

# Update KubePrompts in
# ~/.config/fish/functions/fish_prompt.fish # 613

# https://stackoverflow.com/questions/4421633/who-is-listening-on-a-given-tcp-port-on-mac-os-x
function pport
  lsof -nP -iTCP:$argv | grep LISTEN
end

set -gx PATH $PATH $HOME/.krew/bin

#set -gx KUBECTX_IGNORE_FZF 1
# kube - config management
# kubectx - context management
# kubens - namespace management
function kube
	if count $argv > /dev/null
		# switch to the specified config
		set -gx KUBECONFIG ~/.kube/$argv
	else
		# list kube configs
		grep -le '^contexts:' ~/.kube/* 2> /dev/null | cut -d '/' -f 5
	end
end

alias k "kubectl"

#################################

set -gx MAGEFILE_VERBOSE 1

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
