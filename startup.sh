#!/bin/bash

######################### set up variables

# ${FILE[.vimrc]}
# for i in ${!FILE[@]}
#    key => $i
#    val => ${FILE[$i]}
declare -A FILE=(                        \
    [".vimrc"]=".vimrc"                  \
    [".vim.plug"]=".vim.plug"            \
    [".bashrc"]=".bashrc"                \
    [".bash_aliases"]=".bash_aliases"    \
    [".tmux.conf"]=".tmux.conf"          \
)

CURR_PATH=`pwd`
SCRIPT_PATH=$CURR_PATH/${BASH_SOURCE[0]}

RET=0
JOB=""

DIR_NAME=".bash_set"
DEBUG_MODE=1

######################### tools
_msg() {
    printf "%b\n" "$@"
}

_success() {
    _msg "successs in $1"
}

_error() {
    RET=$?
    _msg "problem in $1"
}

_result() {
    if [ $? -eq 0 ]; then
        _msg "\33[32m[✔]\33[0m $JOB"
    else
        _msg "\33[31m[✘]\33[0m $JOB"
        exit 1
    fi
}

_debug() {
    if [ $DEBUG_MODE -eq 1 ] && [ $? -gt 1 ]; then
        _msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

######################### functions

check_env() {

    JOB="check if \$HOME is set"
    [ -n $HOME ] 
    _result 

    JOB="check if internet is accessable"
    ping -w 1 -q -c 1 `ip r | grep "default" | head -1 |cut -d ' ' -f 3` > /dev/null
    _result 

}

backup() {
    for file in ${FILE[@]}
    do
        if [ -e $HOME/$file ]; then

            JOB="backup $HOME/$file to $HOME/${file}.old"
            mv -i $HOME/$file $HOME/${file}.old
            _result 

        else
            _msg "no need to backup $HOME/$file"
        fi

        JOB="build link for $file"
        ln $file $HOME/
        _result
    done

}

install_pkg() {

    JOB="apt update"
    sudo apt update
    _result 

    JOB="apt install tmux curl git openssh-server"
    sudo apt install tmux curl git openssh-server
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
        -u $HOME/${FILE[.vim.plug]} \
        "+set nomore"               \
        "+PlugInstall!"             \
        "+PlugClean"                \
        "+qall"

    _result 
}

######################### start

check_env

install_pkg

backup

setup_vim_plug
