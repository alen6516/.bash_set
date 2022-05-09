# ls | grep
function lsg()
{
    local cmd="ls -a"
    if [ $# -gt 0 ]; then
        for var in $@
        do
            cmd=$cmd" | grep $var"
        done
    fi

    echo "$cmd"
    echo "---------------"
    eval $cmd
}


# ps aux | grep
function psg()
{
    local cmd="ps -aux"
    if [ $# -gt 0 ]; then
        for var in $@
        do
            cmd=$cmd" | grep $var"
        done
    fi

    echo "$cmd"
    echo "---------------"
    eval $cmd
}


# check my ip info
function ipinfo()
{
    if [ $# = 1 ]; then
        curl ipinfo.io/$1
    else
        curl ipinfo.io
    fi
}

# check it input ip is a remote ip to me
is_remote_ip()
{
   ip route get $1 | grep -q "via $(ip route | awk '/default/ {print $3}') " && echo yes || echo no
}

function ppid() 
{
    var=1234
    ps -o ppid= -p $var
}


# show mem usage
function mem()
{
    if [ $# != 1 ]; then
        echo "Please give process or pid as \$1"
        return 1
    fi
    ps aux | head -n1
    ps aux | grep $1 | grep -v grep | grep $1
    echo -n "$1 totally use memory "
    ps aux | grep $1 | grep -v grep | awk '{ total += $6; } END { print total/1024"MB" }'
}


function open()
{
    if [ $# != 2 ]; then
        echo "usage: open <host> <port>"
    else
        nc -zv $1 $2
    fi
}


trash_can="/tmp/recycle_bin"
function rm()
{
    [ -d $trash_can ] || mkdir $trash_can
    command mv $@ $trash_can
    echo "moving $@ to $trash_can"
}


function rrm()
{
    sudo rm -Ir $@    
}


function cd()
{
    if [[ $# -eq 1 ]] && [[ -f $1 ]]; then
        command cd $@
        read -t 5 -p "Do you want to open it by vim? [yN] " ans
        if [[ $ans == 'y' ]] || [[ $ans == 'Y' ]]; then
            vim $@
        fi
    else
        command cd $@
    fi
}


function man2()
{
    local URL="https://wangchujiang.com/linux-command/"
    [ -z $1 ] && (echo "please give a command as \$1"; exit)
    #ping -c1 -w 3 8.8.8.8 > /dev/null || (echo "Internet is not accessable"; return)
    res=`curl -s -o /dev/null/ $URL -w %{http_code}`
    [ 200 -ne $res ] && (echo "https://wangchujiang.com/linux-command is not accessable"; return)
    w3m ${URL}c/${1} | less
}

function man3()
{
    local URL="http://manpages.ubuntu.com/manpages/bionic/zh_TW/man1/"
    [ -z $1 ] && (echo "please give a command as \$1"; exit)
    res=`curl -s -o /dev/null/ $URL -w %{http_code}`
    [ 200 -ne $res ] && (echo "$URL is not accessable"; return)
    w3m ${URL}${1}.1.html | less
}


# inner funtion for auto completion
function _completion() {

    local COM=""

    case $1 in
        "rfc")
            COM=${!RFC[*]}
            ;;
        "shortcut")
            COM=${!SHORTCUT[*]}
            ;;
        "doc")
            COM=""
            for _dir in ${!DOC[@]}
            do
                for _file in $(ls ~/doc/$_dir)
                do
                    if [[ $_dir == "cmd" ]]; then
                        COM="$COM ${_file%.cmd}"
                    elif [[ $_dir == "api" ]]; then
                        COM="$COM ${_file%.c}"
                    elif [[ $_dir == "prot" ]]; then
                        COM="$COM ${_file%.md}"
                    fi
                done
            done
            ;;
    esac

    #if [ "${#COMP_WORDS[@]}" != "2" ]; then
    #    return
    #fi
    COMPREPLY=($(compgen -W "$COM" "${COMP_WORDS[1]}"))
}


declare -A SHORTCUT=(       \
    ["bash"]="Bash/linux/Bash_Shortcuts"

)
function shortcut() {
    local URL='https://shortcutworld.com/'


    if [ -z $1 ]; then 
        echo "please give a parameter or option"
        return 1
    fi

    res=`curl -s -o /dev/null/ $URL -w %{http_code}`
    if [ 200 -ne $res ]; then
        echo "$URL is not accessable"
        return 2
    fi

    _match=0
    for key in "${!SHORTCUT[@]}"
    do
        if [ "$1" == "$key" ]; then
            _match=1
        fi
    done

    if [ "$_match" == 1 ]; then
        w3m ${URL}${SHORTCUT[$1]} | less
    else
        echo "Uknown shortcut, try again"
    fi
}
complete -F _completion shortcut



declare -A RFC=(            \
    ["arp"]="826"           \
    ["ip"]="791"            \
    ["ipv4"]="791"          \
    ["ipv6"]="2460"         \
    ["icmp"]="792"          \
    ["udp"]="768"           \
    ["tcp"]="793"           \
)
function rfc() {

    local URL='https://tools.ietf.org/html/'
    
    if [ -z $1 ]; then
        echo "please give a protocol or rfc number as \$1"
        return 1
    fi

    res=`curl -s -o /dev/null/ $URL -w %{http_code}`
    if [ 200 -ne $res ]; then
        echo "$URL is not accessable"
        return 2
    fi

    _match=0
    for key in "${!RFC[@]}"
    do
        if [ "$1" == "$key" ]; then
            _match=1
        fi
    done

    if [ "$_match" == 1 ]; then
        w3m ${URL}rfc${RFC[$1]} | less
    else
        w3m ${URL}rfc${1} | less
    fi
}
complete -F _completion rfc



declare -A DOC=(          \
    ["api"]=".c"          \
    ["cmd"]=".cmd"        \
    ["prot"]=".md"        \
)
function doc() {
    local HELP="usage: doc API|CMD|PROT"

    if [[ $# -eq 0 ]]; then
        cd ~/doc
        return 0
    fi

    if [[ ! $# -eq 1 ]]; then
        echo $HELP
    fi

    local file_cmd=""
    for item in $(ls ~/doc/cmd/)
    do
        item=${item%.*}
        file_cmd=$file_cmd" $item"
        #echo $item
    done
    if [[ $file_cmd =~ " $1 " ]]; then
        #echo "${1}.cmd"
        cat ~/doc/cmd/${1}.cmd | less
        return 0
    fi


    local file_api=""
    for item in $(ls ~/doc/api/)
    do
        item=${item%.*}
        file_api=$file_api" $item"
    done
    if [[ $file_api =~ " $1 " ]]; then
        #echo "${1}.c"
        cat ~/doc/api/${1}.c | less
        return 0
    fi


    local file_prot=""
    for item in $(ls ~/doc/prot/)
    do
        item=${item%.*}
        file_prot=$file_prot" $item"
    done
    if [[ $file_prot =~ " $1 " ]]; then
        #echo "${1}.md"
        cat ~/doc/prot/${1}.md | less
        return 0
    fi

    echo "can not find $1"
}
complete -F _completion doc



## for handy
alias tmp='cd ~/vm_share/tmp'
alias _ba='cd ~/.bash_set'
alias ..='cd ..'
alias py='python'
alias py3='python3'
alias od='objdump'
alias rlf='readlink -f'
alias tcpread='tcpdump -r'
alias v-="vim -"
function vv()   # `vv | git show HEAD` => `git show HEAD | vim -`
{
    # not test yet

    if [[ -n $1 ]]; then
        if [[ -n ${BASH_ALIASES[$1]} ]]; then
            # if command is an alias, extract the true command
            local cmd=${BASH_ALIASES[$1]}
            shift
            $cmd $@ | vim -

        else
            # if the command is command or function
            $* | vim -
        fi
    fi
}
alias csd="gtags-cscope -dp6"

## tool
alias port='sudo netstat -antlp'
alias ptt='ssh bbsu@ptt.cc'

#引號裡要打引號前要先用\跳脫，但是也不能直接打 \，否則會被 awk 解析，要打 '\'
alias cpu_load='ps -aux|awk '\''BEGIN{ sum=0} {sum=sum+$3} END{print sum}'\'''
alias mem_load='ps -aux|awk '\''BEGIN{ sum=0} {sum=sum+$4} END{print sum}'\'''

alias info='info --vi-keys'
alias man='man -M /usr/share/man'
alias manc='man -M /usr/share/man/zh_TW'
alias bpf='w3m http://biot.com/capstats/bpf.html | less'


## wrap command
alias cp='cp -i'
alias mv='mv -i'
alias tmux='history -w && tmux'     # write cmd history to .bash_history before using tmux
alias gdb='gdb -q'

## git
alias g="git"
alias gd="git diff"
alias gsh="git show"
alias gco="git checkout"
alias gsw="git switch"
alias gln="git log -3"
alias glln="git log -3 --oneline"
alias gbr="git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'"

function gl()
{
    if [[ $1 = "" ]]; then
        git log HEAD
    elif [[ $1 =~ -[0-9]+$ ]]; then
        git log $1
    elif [[ $1 =~ ^[0-9]+$ ]]; then
        git log -$1
    else
        command_not_found_handle ${FUNCNAME[0]} $1
    fi
}
function gll()
{
    if [[ $1 = "" ]]; then
        git log --oneline HEAD
    elif [[ $1 =~ -[0-9]+$ ]]; then
        git log --oneline $1
    elif [[ $1 =~ ^[0-9]+$ ]]; then
        git log --oneline -$1
    else
        command_not_found_handle ${FUNCNAME[0]} $1
    fi
}
function glp()
{
    if [[ $1 = "" ]]; then
        git log --pretty=format:"%h%x09%an%x09%ad%x09%s" HEAD
    elif [[ $1 =~ -[0-9]+$ ]]; then
        git log --pretty=format:"%h%x09%an%x09%ad%x09%s" $1
    elif [[ $1 =~ ^[0-9]+$ ]]; then
        git log --pretty=format:"%h%x09%an%x09%ad%x09%s" -$1
    else
        command_not_found_handle ${FUNCNAME[0]} $1
    fi
}


if [ -f ~/.bash_company ]; then
    . ~/.bash_company
fi
