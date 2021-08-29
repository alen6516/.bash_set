#!/bin/bash

# tmux send-keys -t "$pane" C-z 'pwd' Enter



#SESSIONNAME="script"
#tmux has-session -t $SESSIONNAME &> /dev/null
#
#if [ $? != 0 ]; then
#    tmux new-session -s $SESSIONNAME -n script -d
#    tmux send-keys -t $SESSIONNAME "~/bin/script" C-m 
#fi
#tmux attach -t $SESSIONNAME


date=`date +%m%d`
time=`date +%H%M%S`

file_name="$HOME/.tmux_session_$date$time"
touch $file_name
echo -n "" > $file_name

for session in `tmux ls | cut -d ":" -f 1`
do
    #tmux send-keys -t ${session} Escape
    tmux send-keys -t ${session} C-z
    tmux send-keys -t ${session} "echo -n ${session}: >> ${file_name} && pwd >> ${file_name}; fg" Enter

    #tmux new-window -t ${session} -c '#{pane_current_path}' -n ${wdw}
    #tmux send-keys -t ${session}:${wdw} "echo -n ${session}: >> ${file_name} && pwd >> ${file_name} && logout" Enter
done
