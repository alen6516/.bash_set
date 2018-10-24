#!/bin/bash

######################### set up variables

declare -A FILE=(                        \
    [".vim"]=".vim"                      \
    [".vimrc"]=".vimrc"                  \
    [".vim_plug"]=".vim_plug"            \
    [".bashrc"]=".bashrc"                \
    [".bash_aliases"]=".bash_aliases"    \
    [".tmux.conf"]=".tmux.conf"          \
)

CURR_PATH=`pwd`
SCRIPT=`realpath $0`
SCRIPT_PATH=`dirname $SCRIPT`
DATE=`date +"%Y%m%d"`

RET=0
JOB=""

DIR_NAME=".bash_set"
LOG_PATH="/tmp/bash_set.log"
DEBUG_MODE=1

######################### tools
_msg() {
    printf "%b\n" "$*"
}

# deprecated, use _result
_success() {
    _msg "successs in $1"
}

# deprecated, use _result
_error() {
    RET=$?
    _msg "problem in $1"
}

_result() {
    if [ $? -eq 0 ]; then
        #_msg "\33[32m[✔]\33[0m $JOB"
        echo "\\\33[32m[✔]\\\33[0m $JOB" >> $LOG_PATH
    else
        #_msg "\33[31m[✘]\33[0m $JOB"
        echo "\\\33[32m[✔]\\\33[0m $JOB" >> $LOG_PATH
        show_log
        exit 1
    fi
}

_debug() {
    if [ $DEBUG_MODE -eq 1 ] && [ $? -gt 1 ]; then
        _msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

######################### functions

init() {

    echo "" > $LOG_PATH
}

check_env() {

    JOB="check if \$HOME is set"
    [ -n $HOME ] 
    _result 

    JOB="check if internet is accessable"
    #ping -w 1 -q -c 1 `ip r | grep "default" | head -1 |cut -d ' ' -f 3` > /dev/null
    ping -w 1 -c1 8.8.8.8 > /dev/null
    _result 

}

backup() {
    for file in ${FILE[@]}
    do
        if [ -e $HOME/$file ]; then
            JOB="backup $HOME/$file to $HOME/${file}.$DATE"
            mv -i $HOME/$file $HOME/${file}.$DATE
            _result 
        fi
    done
}

build_link() {
    for file in ${FILE[@]}
    do
	    if [ -f $SCRIPT_PATH/$file ]; then
            JOB="build link for $file"
            touch $HOME/$file
            ln -sf $SCRIPT_PATH/$file $HOME/$file
            _result
        fi
    done
}

install_pkg() {

    JOB="apt update"
    sudo apt update
    _result 

    JOB="apt install vim tmux curl git openssh-server w3m"
    sudo apt install vim tmux curl git openssh-server w3m
    _result 
    
    JOB="install vim-plug"
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
    _result 

    JOB="install ctags"
    sudo apt install -y exuberant-ctags 
    _result 

    JOB="install cscope"
    #sudo apt install -y cscope
    #_result 

    JOB="install YCM"
    #TODO: command to install YCM

    # let systastic to suppport python
    JOB="install pylint"
    sudo apt install -y pylint 
    _result 

    #install vim-autopep8"
    JOB="install python3-pip"
    sudo apt install -y python3-pip
    _result 

    JOB="upgrade pip"
    sudo pip3 install --upgrade pip
    _result

    JOB="install autopep8"
    sudo pip3 install --upgrade autopep8
    _result 

}

setup_vim_plug() {

    JOB="set up vim plug"
    vim \
        -u $HOME/${FILE[.vim_plug]} \
        "+set nomore"               \
        "+PlugInstall!"             \
        "+PlugClean"                \
        "+qall"

    _result 
}

show_log() {
    exec < $LOG_PATH
    while read line
    do
        _msg $line
    done
}

######################### start

init

check_env

backup

build_link

install_pkg

setup_vim_plug

show_log
