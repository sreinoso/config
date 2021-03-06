# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Custom bash prompt via kirsle.net/wizards/ps1.html
# export PS1="\[$(tput setaf 2)\]################\n\[$(tput bold)\]\[$(tput setaf 1)\][\u@\h \W]\>\[$(tput sgr0)\]\[$(tput setaf 2)\]\[$(tput sgr0)\]"

export PS1="\[\e[01;31m\]\$?\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[01;31m\]\@\[\e[0m\]\[\e[00;37m\]\n\[\e[0m\]\[\e[00;32m\]\u\[\e[0m\]\[\e[01;37m\]@\[\e[0m\]\[\e[00;32m\]\h\[\e[0m\]\[\e[01;37m\]:\[\e[0m\]\[\e[01;31m\]\w\[\e[0m\]\[\e[01;33m\]-->\[\e[0m\]\[\e[00;37m\]\n\[\e[0m\]"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    
    PS1="\[\e[01;31m\]\$?\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[01;31m\]\@\[\e[0m\]\[\e[00;37m\]\n\[\e[0m\]\[\e[00;32m\]\u\[\e[0m\]\[\e[01;37m\]@\[\e[0m\]\[\e[00;32m\]\h\[\e[0m\]\[\e[01;37m\]:\[\e[0m\]\[\e[01;31m\]\w\[\e[0m\]\[\e[01;33m\]-->\[\e[0m\]\[\e[00;37m\]\n\[\e[0m\]"
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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


export Disco="~/CLASE/";
export M3="~/CLASE/M3/UF4";
export M5="~/CLASE/M5/UF2";
export M6="~/CLASE/M6/UF2";
export M7="~/CLASE/M7/UF3";
export M8="~/CLASE/M8/UF2";
export M9="~/CLASE/M9/UF1";
export bashrc="~/.bashrc";
export vimrc="~/.vimrc";
export Clase="~/CLASE/daw2/";

alias Disco="cd /media/13194DCD211F8F37/";
alias M3="cd ~/CLASE/M3/UF4";
alias M5="cd ~/CLASE/M5/UF2";
alias M6="cd ~/CLASE/M6/UF2";
alias M7="cd ~/CLASE/M7/UF3";
alias M8="cd ~/CLASE/M8/UF2";
alias M9="cd ~/CLASE/M9/UF1";
alias vimrc="vim ~/.vimrc";
alias bashrc="vim ~/.bashrc";
alias clase="cd ~/CLASE";
alias Clase="cd ~/CLASE";
alias CLASE="cd ~/CLASE";
alias ..="cd ..";
alias ifmore="ifconfig | more"; 
alias ll="ls -la"; 

NOW=$(date +"%d-%m-%Y");
alias mypush="git add * ; git commit -m $NOW; git push git@github.com:sreinoso/DAW2"

#   Crea directorio y entra en el
function mkcd(){
    [ -n "$1" ] && mkdir -p "$@" && cd "$1";
}
##

function findrm(){
    DIR="$1";
    DEL="$2";
    find $DIR -name $DEL -exec rm {} \;
}

CLASSPATH=.
CLASSPATH=$CLASSPATH:$HOME/lib/postgresql-9.4-1201.jdbc41.jar
#export CLASSPATH=$CLASSPATH:~/lib/junit.jar
#export CLASSPATH=$CLASSPATH:~/lib/hamcrest-core.jar
#CLASSPATH=$CLASSPATH:$HOME/lib/postgresql-9.4-1201.jdbc4.jar
#lib/
export CLASSPATH
PATH=$PATH:~/soft/apache-maven/actual/bin
