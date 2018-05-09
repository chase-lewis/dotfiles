#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# added by Miniconda3 installer
export PATH="/home/chase/miniconda3/bin:$PATH"
