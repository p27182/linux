#!/bin/bash

# You may uncomment the following lines if you want `ls' to be colorized:
 export LS_OPTIONS='--color=auto'
 eval "`dircolors`"
 alias ls='ls $LS_OPTIONS'
 alias ll='ls $LS_OPTIONS -la'

# Some more alias to avoid making mistakes:
 alias rm='rm -i'
 alias cp='cp -i'
 alias mv='mv -i'
 alias sudo='sudo '

#because systemctl is annoying
alias sys='systemctl'

# because arguments are dumb
alias watch='watch -n 1'

# Color/bold defs
grey='\[\033[1;30m\]'
red='\[\033[0;31m\]'
RED='\[\033[1;31m\]'
green='\[\033[0;32m\]'
GREEN='\[\033[1;32m\]'
yellow='\[\033[0;33m\]'
YELLOW='\[\033[1;33m\]'
purple='\[\033[0;35m\]'
PURPLE='\[\033[1;35m\]'
white='\[\033[0;37m\]'
WHITE='\[\033[1;37m\]'
blue='\[\033[0;34m\]'
BLUE='\[\033[1;34m\]'
cyan='\[\033[0;36m\]'
CYAN='\[\033[1;36m\]'
NC='\[\033[0m\]'

#color prompt
#[18:48:03][percona1][/home/gkadmin]#
#PS1="$grey[$cyan\t$grey][$RED\H$grey][$GREEN\w$grey$grey]$NC# "
#[user][hostname][directory]#
PS1="$white[$cyan\u$white][$RED\H$white][$GREEN\w$white]$NC# "

#add date n timestamp
export HISTTIMEFORMAT='%F, %T '

#set history filesize to 100k lines
HISTFILESIZE=100000

#set param to write cmds to hist as they are executed (instead of end of session)
PROMPT_COMMAND='history -a'
