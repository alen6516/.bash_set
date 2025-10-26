#!/bin/bash

######################### set up variables

declare -A FILE=(                           \
    [".vimrc"]=".vimrc"                     \
    [".bashrc"]=".bashrc"                   \
    [".bash_aliases"]=".bash_aliases"       \
    [".tmux.conf"]=".tmux.conf"             \
    [".gitconfig"]=".gitconfig"             \
    [".cscope_maps.vim"]=".cscope_maps.vim"  \
    #[".vim"]=".vim"                         \
    #[".vim_plug"]=".vim_plug"               \
    #[".ctags"]=".ctags"                     \
    #[".gdbinit"]=".gdbinit"                 \
)

CURR_PATH=`pwd`
SCRIPT=`realpath $0`
SCRIPT_PATH=`dirname $SCRIPT`
BACKUP_PATH="${SCRIPT_PATH}/_backup"
DIR_NAME=".bash_set"
DATE=`date +"%Y%m%d"`

RET=0
JOB=""

LOG="${BACKUP_PATH}/bash_set.log"
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
        echo "\\\33[32m[✔]\\\33[0m $JOB" >> $LOG
    else
        #_msg "\33[31m[✘]\33[0m $JOB"
        echo "\\\33[31m[✘]\\\33[0m $JOB" >> $LOG
        show_log
        echo "installation fail due to an error..."
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

    mkdir -p $BACKUP_PATH
    echo "" > $LOG
}

check_env() {

    JOB="check if \$HOME is set"
    [ -n $HOME ]
    _result

    JOB="check distro"
    local os_release=$(cat /etc/os-release)
    case "$os_release" in
    *ubuntu*)
        PKG_TOOL="apt"
        ;;
    *debian*)
        PKG_TOOL="apt"
        ;;
    *manjaro*)
        PKG_TOOL="pacman"
        ;;
    *arch*)
        PKG_TOOL="pacman"
        ;;
    *)
        ;;
    esac
    echo "Distro is $DISTRO"

    JOB="check if internet is accessable"
    #ping -w 1 -q -c 1 `ip r | grep "default" | head -1 |cut -d ' ' -f 3` > /dev/null
    ping -w 1 -c1 8.8.8.8 > /dev/null
    _result

}

backup()
{
    for file in ${FILE[@]}
    do
        if [ -e $HOME/$file ]; then
            JOB="backup $HOME/$file to $SCRIPT_PATH/_backup/${file}_$DATE"
            mv --backup $HOME/$file $SCRIPT_PATH/_backup/${file}_$DATE
            _result
        fi
    done
}

build_link()
{
    for file in ${FILE[@]}
    do
	    if [ -f $SCRIPT_PATH/$file ]; then
            JOB="build link for $file"
            touch $HOME/$file && ln -sf $SCRIPT_PATH/$file $HOME/$file
            _result
        fi
    done
}

install_pkg()
{
    PKG="vim tmux curl git w3m bc global sshfs"
    # w3m: command line based web browser, for my man2 command
    # bc: command line calculater tool, for bash to calculate float val
    # manpages-zh: manpages in zh_TW, for my manc
    case "$PKG_TOOL" in
    apt)
        sudo apt update -y
	PKG=$PKG" ssh manpages-zh"
	sudo apt install -y $PKG
        ;;
    pacman)
        sudo pacman -Sy --noconfirm
	PKG=$PKG" openssh"
	sudo pacman -S --noconfirm $PKG
        ;;
    *)
        ;;
    esac
    JOB="Install $PKG"
    _result
    
    #JOB="install vim-plug"
    #curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    #    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    #_result

    #JOB="install ctags"
    #sudo apt install -y exuberant-ctags
    #_result

    #JOB="install cscope"
    ##sudo apt install -y cscope
    ##_result

    #JOB="install YCM dependencies"
    #(( $(echo `lsb_release -rs` ">= 16.04" | bc -l) )) && (sudo apt install -y build-essential cmake python3-dev) || (sudo apt install -y build-essential cmake3 python3-dev)
    #_result

    ## let systastic to suppport python
    #JOB="install pylint"
    #sudo apt install -y pylint
    #_result

    ##install vim-autopep8"
    #JOB="install python3-pip"
    #sudo apt install -y python3-pip
    #_result

    #JOB="upgrade pip"
    #sudo pip3 install --upgrade pip
    #_result

    #JOB="install autopep8"
    #sudo pip3 install --upgrade autopep8
    #_result

}

setup_vim_plug()
{

    JOB="set up vim plug"
    vim \
        -u $HOME/${FILE[.vim_plug]} \
        "+set nomore"               \
        "+PlugInstall!"             \
        "+PlugClean"                \
        "+qall"

    _result

    JOB="install YCM"
    python3 ~/.vim/plugged/YouCompleteMe/install.py --clang-completer && \
    git clone https://gist.github.com/4950253.git /tmp/ycm_tmp && \
    mv /tmp/ycm_tmp/.ycm_extra_conf.py ~/.vim/plugged/YouCompleteMe/ && \
    command rm -rf /tmp/ycm_tmp
    _result
}

show_log()
{
    _msg "log is save in $LOG and show below"
    exec < $LOG
    while read line
    do
        _msg $line
    done
}

source_config()
{
    if [[ "$SHELL" != "/bin/bash" ]]; then
        sudo chsh $USER -s /bin/bash
    else
        source $HOME/.bashrc
        source $HOME/.bash_aliases
    fi
}

######################### start

init

check_env

backup

build_link

install_pkg

#setup_vim_plug

show_log

source_config
