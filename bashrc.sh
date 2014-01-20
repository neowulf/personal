#!/bin/bash

export LC_CTYPE=C

#[ -z "$PS1" ] && return
platform=${platform:-macosx}

###############################
## FUNCTIONS
###############################

function videa() { 
	if [[ $platform == 'linux' ]]; then
		idea `pwd`/$1 
	elif [[ $platform == 'macosx' ]]; then
		/Applications/IntelliJ\ IDEA\ 12.app/Contents/MacOS/idea `pwd`/${1}
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
	if [[ $platform == 'linux' ]]; then
	  diff $1 .svn/text-base/$1.svn-base; 
	elif [[ $platform == 'macosx' ]]; then
	  opendiff $1 .svn/text-base/$1.svn-base; 
	fi
}

function restartvpn {
  sudo launchctl stop com.apple.racoon
  sudo launchctl start com.apple.racoon
}

###############################
## PROMPT
###############################
PS1='`date "+%H%M.%S"` \u@\h:\W\$ '
# Mint Flavor
PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\]"
PS1="\$(date_txt) \u@\h:\W\[\033[0;32m\]\$(parse_git_branch_and_add_brackets)\[\033[0m\] \$ "

###############################
## HISTORY
###############################
# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
export LESS="-R"
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

###############################
## ENV VARIABLES
###############################

if [[ $platform == 'linux' ]]; then
	export EDITOR="vim"
	export SVN_EDITOR="vim"
	export JDK_HOME="/usr/lib/jvm/java-6-sun"
	export JAVA_HOME="/usr/lib/jvm/java-6-sun"
elif [[ $platform == 'macosx' ]]; then
	export EDITOR='mate -w'
	export JAVA_HOME=$(/usr/libexec/java_home)
	export GROOVY_HOME="/usr/local/Cellar/groovy/2.1.1/libexec"
	export GIT_EDITOR="mate -w -l 1"
	export M2_HOME="/usr/local/Cellar/maven2/2.2.1"
fi

export MAVEN_OPTS="-Xms128m -Xmx512m -XX:MaxPermSize=256m"
export PATH="/usr/local/bin:~/.personal/bin:${PATH}"

###############################
## COMMON UTILITIES
###############################

if [[ $platform == 'linux' ]]; then
	alias ls='ls --color=auto'
elif [[ $platform == 'macosx' ]]; then
	# gsed is a sed from cellar
	alias sed="gsed"
	alias "ij=open -a /Applications/IntelliJ\ IDEA\ 12.app"
	alias ls='ls -G'
fi

alias grep="grep --color -n --exclude=\*.svn\*"
#alias killtcs="ps -ef | mgrep -i bootstrap | awk '{print $2}' | xargs kill"
alias mgrep="grep -v grep | grep"
alias pj="python -mjson.tool"
alias pp="lsof -i -P"
alias sortdirs="du -k * | sort -n -r | head -n 20"
alias sumdirs="du -k -s * | sort -k1 -g -r"
alias vi="vim"

# alias enclock="fusermount -u ~/.passwords"
# alias sc="enclock  && gnome-screensaver-command --lock"
# alias unlock="(df | grep '/home/siva/.passwords' > /dev/null) || encfs ~/.passwords.encrypted ~/.passwords"
# function encrypt() { openssl des3 -e -a -in $1 -out $1.des3; mv $1.des3 $1; }
# function decrypt() { openssl des3 -d -a -in $1 -out $1.tmp; mv $1.tmp $1; }

###############################
## Quick Naviation - Marks - http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
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
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark
