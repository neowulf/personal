# Update KubePrompts in
# ~/.config/fish/functions/fish_prompt.fish # 613

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

function kubectl_status
  [ -z "$KUBECTL_PROMPT_ICON" ]; and set -l KUBECTL_PROMPT_ICON "⎈"
  [ -z "$KUBECTL_PROMPT_SEPARATOR" ]; and set -l KUBECTL_PROMPT_SEPARATOR "/"
  set -l config $KUBECONFIG
  [ -z "$config" ]; and set -l config "$HOME/.kube/config"
  if [ ! -f $config ]
    echo (set_color red)$KUBECTL_PROMPT_ICON" "(set_color white)"no config"
    return
  end

  set -l ctx (kubectl config current-context 2>/dev/null)
  if [ $status -ne 0 ]
    echo (set_color red)$KUBECTL_PROMPT_ICON" "(set_color white)"no context"
    return
  end

  set -l ns (kubectl config view -o "jsonpath={.contexts[?(@.name==\"$ctx\")].context.namespace}")
  [ -z $ns ]; and set -l ns 'default'

  echo (set_color cyan)$KUBECTL_PROMPT_ICON" "(set_color white)"($ctx$KUBECTL_PROMPT_SEPARATOR$ns)"
end

alias k "kubectl"
alias kc "k config get-contexts | awk '{print $1}'"
alias kg "k get" 
alias kd "k describe" 
alias ke "k edit" 
alias kl "k logs -f --tail=100"

alias kdump "k cluster-info dump -A --output-directory=/tmp/dump & pushd /tmp/dump"

alias kclear "k config unset current-context"
alias klist  "k config get-contexts"
alias kdel   "k config delete-context"

alias dc "docker-compose"
alias dcb "docker-compose build --parallel --compress --force-rm --no-cache --pull"
alias dcd "docker-compose down --remove-orphans -v"
alias dcu "docker-compose up --build"

alias bb "k run busybox --image=busybox:latest --rm -it --restart=Never --overrides='{ \"apiVersion\": \"v1\", \"metadata\": {\"annotations\": { \"sidecar.istio.io/inject\":\"false\" } } }' --command --"
