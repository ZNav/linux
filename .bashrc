#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias rs="reset"
alias ..="cd .."
alias kill="exit"
alias power="sudo shutdown -h now"
alias rcload="source ~/.bashrc"
alias logout="loginctl terminate-user z"
startx
