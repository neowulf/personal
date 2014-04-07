#!/bin/bash

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PERSONAL_DIR="$(cd "${CUR_DIR}" && cd .. && pwd )"

###############################
## FUNCTIONS
###############################

function videa() {
    if [ $(uname) == "Darwin" ]; then
        ${HOME}/Applications/IntelliJ\ IDEA\ 13.app/Contents/MacOS/idea `pwd`/${1}
    else
        idea `pwd`/$1
    fi
}

function parse_git_branch_and_add_brackets {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}

function date_txt {
    date +%H%M.%S
}

function memcache_flush_all {
    echo "flush_all" | nc localhost 11211
}

function killtcs {
    ps -ef | \grep Bootstrap | \grep -v 'grep' | awk '{print $2}' | xargs kill -9
}

function od {
    if [ $(uname) == "Darwin" ]; then
      opendiff $1 .svn/text-base/$1.svn-base;
	else
      diff $1 .svn/text-base/$1.svn-base;
	fi
}

function restartvpn {
    sudo launchctl stop com.apple.racoon
    sudo launchctl start com.apple.racoon
}

###############################
## Quick Navigation - Marks - http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
###############################

export MARKPATH=$HOME/.marks
function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
_completemarks() {
    local curw=${COMP_WORDS[COMP_CWORD]}
    if [ $(uname) == "Darwin" ]; then
      local wordlist=$(find $MARKPATH -type l -print0 | xargs -0 | \sed 's/\/Users\/siva\/.marks\///g')
    else
      local wordlist=$(find $MARKPATH -type l -printf "%f\n")
    fi
    COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
    return 0
}

complete -F _completemarks jump unmark