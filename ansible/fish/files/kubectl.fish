# Update KubePrompts in
# ~/.config/fish/functions/fish_prompt.fish # 613

set -gx PATH $PATH $HOME/.krew/bin

#set -gx KUBECTX_IGNORE_FZF 1
# kube - config management
# kubectx - context management
# kubens - namespace management
function kube
	if count $argv > /dev/null
        # alternatively configure the kubeconfig on the cmdline like so:
        #       alias kc="kubectl --kubeconfig=sv.kubeconfig"

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
alias kgw "k get -o wide --show-labels" 
alias kgy "k get -o yaml" 

alias kd "k describe" 
alias ke "k edit" 
alias kl "k logs -f --tail=100"
alias kpf "k port-forward"

alias kdump "k cluster-info dump -A --output-directory=/tmp/dump & pushd /tmp/dump"

alias kclear "k config unset current-context"
alias klist  "k config get-contexts"
alias kdel   "k config delete-context"

alias kubuntu "k run ubuntu --image=ubuntu:latest --rm -it --restart=Never --command --"
alias kcurl "k run curl --image=curlimages/curl:latest --rm -it --restart=Never --command -- sh"
alias ksleep "k apply -f https://raw.githubusercontent.com/istio/istio/master/samples/sleep/sleep.yaml"

alias dc "docker-compose"
alias dcb "docker-compose build --parallel --compress --force-rm --no-cache --pull"
alias dcd "docker-compose down --remove-orphans -v"
alias dcu "docker-compose up --build"

# https://istio.tetratelabs.io/getistio-cli/reference/getistio/
alias istioctl "getistio istioctl"
alias i "getistio istioctl"

alias ic "i pc clusters"        # -o json --fqdn reviews.default.svc.cluster.local
alias il "i pc listeners"       # -o json --address 0.0.0.0 --port 9080
alias ir "i pc routes"          # -o json --name 9080
alias ie "i pc endpoints"       # --cluster "outbound|9080||reviews.default.svc.cluster.local"
alias ib "i pc bootstrap"

# istio debug
alias ictrlz "i dashboard controlz deployment/istiod.istio-system"
alias idebug "open http://localhost:8080/debug ; k -n istio-system port-forward deploy/istiod 8080"
# https://github.com/istio/istio/blob/25f4ef492781382b2da58bff5f3620c48e06cfce/pilot/pkg/xds/debug.go#L151
#   curl -sS istiod.istio-system:15014/debug/endpointz

# pilot metrics/debug endpoint - https://istio.io/latest/docs/reference/commands/pilot-discovery/#pilot-discovery-request
#   pilot-agent request GET server_info --log_as_json

alias pilotrestart "k -n istio-system delete po -l app=istiod"
