# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt adam1

setopt histignorealldups
setopt sharehistory
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# auto compleeeete
. /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=31'

# alias jawns
 export LS_OPTIONS='--color=auto'
 eval "`dircolors`"
 alias ls='ls $LS_OPTIONS'
 alias ll='ls $LS_OPTIONS -lah'

# Some more alias to avoid making mistakes:
 alias rm='rm -i'
 alias cp='cp -i'
 alias mv='mv -i'
# alias sudo='sudo '

# history all the thangs
alias history='history 0'

#because systemctl is annoying
alias sys='systemctl'

# because arguments are dumb
alias watch='watch -n 1'

#####
#prompty boi
####
autoload -U colors && colors

#prompt info vars
result='%(?.%F{green}√.%F{red}💀%?)%f%F{grey}'
tstamp='⌚%F{7}%t%F{grey}'
user='%F{6}%n%F{grey}'
host='%F{white}%m%F{grey}'
dir='%F{yellow}📁%~%F{reset}'
#ips var
iplist=$(ip -o -4 addr show | awk '$2!="lo" {print$2":"$4}' | tr '\n' ' ')
ip=${iplist%?}
lan='%F{grey}'$ip'%F{grey}'

#prompt lines
p1=$'%F{green}┌─['$result'%F{green}]─['$tstamp'%F{green}]─['$lan'%F{green}]'
p2=$'\n%F{green}└─[%B'$user'%b%F{green}@%B%F{5}'$host'%b%F{green}]─['$dir'%F{green}]➣'

#prompt
PROMPT=$p1$p2

