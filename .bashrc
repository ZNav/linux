#
# ~/.bashrc
#
#TODO
#fix hyprland keybinds for floating windows
#get theme for hyprpanel
#start development of website for NRG info

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
alias wifi="sudo iwctl"
alias run="Hyprland"
alias n="neofetch"
alias f="fastfetch"
alias screensaver="cbonsai -S"
#this prints fastfetch on terminal open
sleep 0.2
fastfetch

#wifi connection instructions
#nmcli d wifi connect "SSID"
