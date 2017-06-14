function lsg()
{
    if [ $# = 1 ]; then
        ls -a | grep $1
    elif [ $# = 2 ]; then
        ls -a $1 | grep $2
    fi
}

function psg()
{
    if [ $# = 0 ]; then
        ps -aux
    elif [ $# = 1 ]; then
        ps -aux | grep $1
    fi
}
function ipinfo()
{
    if [ $# = 1 ]; then
        curl ipinfo.io/$1
    else
        echo "please assign the IP address"
    fi
}

alias port='sudo netstat -antlp'
alias py='python'
alias ptt='ssh bbsu@ptt.cc'
