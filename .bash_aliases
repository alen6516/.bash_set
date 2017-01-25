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

alias port='sudo netstat -antlp'
alias py='python'
