#!/bin/sh

export LC_CTYPE=C

#[ -z "$PS1" ] && return

###############################
## FUNCTIONS
###############################
#function videa() { idea `pwd`/$1 }

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
  opendiff $1 .svn/text-base/$1.svn-base; 
}

function restartvpn {
  sudo launchctl stop com.apple.racoon
  sudo launchctl start com.apple.racoon
}

###############################
## PROMPT
###############################
PS1='`date "+%H%M.%S"` \u@\h:\W\$ '
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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
#export EDITOR="vim"
export EDITOR='mate -w'
export SVN_EDITOR="vim"
#export JDK_HOME="/usr/lib/jvm/java-6-sun"
#export JAVA_HOME="/usr/lib/jvm/java-6-sun"
export JAVA_HOME="/Library/Java/Home"
export GROOVY_HOME="/usr/local/Cellar/groovy/2.1.1/libexec"
# export GIT_EDITOR="mate2 --name 'Git Commit Message' -w -l 1"
export GIT_EDITOR="mate -w -l 1"

export MAVEN_OPTS="-Xms128m -Xmx512m -XX:MaxPermSize=256m"
export PATH="/Applications/GoogleAppEngineLauncher.app/Contents/Resources/GoogleAppEngine-default.bundle/Contents/Resources/google_appengine:/usr/local/bin:/usr/local/binscripts:/usr/local/binscripts/git-aliae-bin:${PATH}"

###############################
## COMMON UTILITIES
###############################
alias browse='nautilus'
alias grep="grep --color -n --exclude=\*.svn\*"
#alias killtcs="ps -ef | mgrep -i bootstrap | awk '{print $2}' | xargs kill"
alias ls='ls -G'
alias mgrep="grep -v grep | grep"
alias pj="python -mjson.tool"
alias pp="lsof -i -P"
# gsed is a sed from cellar
alias sed="gsed"
alias sortdirs="du -k * | sort -n -r | head -n 20"
alias sumdirs="du -k -s * | sort -k1 -g -r"
alias vi="vim"

alias enclock="fusermount -u ~/.passwords"
alias sc="enclock  && gnome-screensaver-command --lock"
alias unlock="(df | grep '/home/siva/.passwords' > /dev/null) || encfs ~/.passwords.encrypted ~/.passwords"
# function encrypt() { openssl des3 -e -a -in $1 -out $1.des3; mv $1.des3 $1; }
# function decrypt() { openssl des3 -d -a -in $1 -out $1.tmp; mv $1.tmp $1; }

alias "ij=open -a /Applications/IntelliJ\ IDEA\ 12.app"
