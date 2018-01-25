#CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#PERSONAL_DIR="$(cd "${CUR_DIR}" && cd .. && pwd )"
#alias ls='ls -G'
#alias ls='ls --color=auto' 
alias grep="grep --color --exclude=\*.svn\*"
#alias killtcs="ps -ef | mgrep -i bootstrap | awk '{print $2}' | xargs kill"
alias mgrep="grep -v grep | grep"
alias pj="python -mjson.tool"
alias pp="lsof -i -P"
alias sortdirs="du -k * | sort -n -r | head -n 20"
alias sumdirs="du -k -s * | sort -k1 -g -r"
alias agl="ag --pager less"
alias git="hub"
