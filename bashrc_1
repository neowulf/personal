#!/bin/sh

export LC_CTYPE=C

PS1='`date "+%H%M.%S"` \u@\h:\W\$ '

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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


#################################
#
#	User Defined
#
#################################

###############################
## ENV VARIABLES
###############################

export EDITOR="vim"
export SVN_EDITOR="vim"
export JDK_HOME="/usr/lib/jvm/java-6-sun"
export JAVA_HOME="/usr/lib/jvm/java-6-sun"
export MAVEN_OPTS="-Xms128m -Xmx512m -XX:MaxPermSize=256m"
export MAVEN_HOME="/usr/share/maven2"
export M2_HOME="/usr/share/maven2"

export PATH="${PATH}:/var/lib/gems/1.9.1/bin"

###############################
## COMMON UTILITIES
###############################
alias enclock="fusermount -u ~/.passwords"
alias sc="enclock  && gnome-screensaver-command --lock"
alias unlock="(df | grep '/home/siva/.passwords' > /dev/null) || encfs ~/.passwords.encrypted ~/.passwords"

alias ack="ack-grep"
alias grep="grep --color -n --exclude=\*.svn\*"
alias mgrep="grep -v grep | grep"
alias sortdirs="du -k * | sort -n -r | head -n 20"
alias sumdirs="du -k -s * | sort -k1 -g -r"
alias browse='nautilus'
alias pp="lsof -i -P"
#alias killtcs="ps -ef | mgrep -i bootstrap | awk '{print $2}' | xargs kill"

function encrypt() { openssl des3 -e -a -in $1 -out $1.des3; mv $1.des3 $1; }
function decrypt() { openssl des3 -d -a -in $1 -out $1.tmp; mv $1.tmp $1; }
