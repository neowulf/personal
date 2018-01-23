#!/bin/bash

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PERSONAL_DIR="$(cd "${CUR_DIR}" && cd .. && pwd )"

###############################
## FUNCTIONS
###############################

function videa() {
    if [ $(uname) == "Darwin" ]; then
        /Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea `pwd`/${1}
    else
        idea `pwd`/$1
    fi
}

function ae {
    # gem install airplay airplay-cli airplayer airstream
    #air play $(youtube-dl -g "${@}")
    airstream $(youtube-dl -g "${@}") -o apple-tv ##`air list | grep ip | cut -d ':' -f 3`
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

function od {
    if [ $(uname) == "Darwin" ]; then
      opendiff $1 .svn/text-base/$1.svn-base;
	else
      diff $1 .svn/text-base/$1.svn-base;
	fi
}

# Allows for iterm title to be updated - http://superuser.com/a/599156/261889
function iterm_title {
    echo -ne "\033]0;"$*"\007"
}

function mm {
    \grep Service ~/.ssh/magicmirror_formatted.json | \grep --colour $@
}

function local_servers {
    netstat -anp | grep java | awk '{print $4}' | cut -d ':' -f 1 | sort -u | grep \\.
}

function remote_servers {
    netstat -anp | grep java | awk '{print $5}' | cut -d ':' -f 1 | sort -u | grep \\.
}

function _update_brew {

    ### Force uninstalls failed python
    #$ brew uninstall -f python
    
    ### Clear the brew cache
    #$ rm -rf `brew --cache`
    
    ### Recreate the brew cache
    #$ mkdir `brew --cache`
    
    ### Cleanup - cleans up old homebrew files
    #$ brew cleanup
    
    ### Prune - removes dead symlinks in homebrew
    #$ brew prune
    
    ### Doctor - runs homebrew checks for common error causing issues
    #$ brew doctor
    
    brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup
}