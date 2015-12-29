# Path to your oh-my-zsh installation.
export ZSH=/home/permafrost/.oh-my-zsh

ZSH_THEME="robbyrussell"
HIST_STAMPS="dd.mm.yyyy"

PAGER="less -R"
EDITOR="vim"
MAIL=$HOME/var/mail/inbox
SUDO_EDITOR=vim

export PAGER EDITOR MAIL SUDO_EDITOR

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/permafrost/bin/"

# colored man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;33;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

plugins=(git)

# User configuration

source $ZSH/oh-my-zsh.sh

alias s="sudo"
alias v="vim"
alias sv="sudo vim"
alias c="clear"
alias z="zsh"

# functions

function mu-thread() {
	curl $1 | egrep -o "\"https\:\/\/www\.youtube\.com\/watch\?v\=[a-zA-Z0-9_-]*\"" | uniq | xargs mpv -vo=null
}

#cd () {
#  builtin cd $@ && ls -CF
#}

#█▓▒░ minial prompt
PROMPT='${USER_LEVEL}[%F{white}%~${USER_LEVEL}]── -%f '
#PROMPT='» '
