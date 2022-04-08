#1/usr/bin/env bash

languages=$(echo "golang c cpp typescript java rust" | tr " " "\n")
core_utils=$(echo "bash find xargs sed awk" | tr " " "\n")
selected=$(echo "$languages\n$core_utils" | fzf)

if [ -z "$selected" ]; then
    exit 0;
fi

read -p "Query> " query

if [ -z "$query" ]; then
    exit 0;
fi

command=""
if echo "$languages" | grep -qs $selected; then
    command="curl -s cht.sh/$selected/$(echo "$query" | tr " " "+") | less"
    
else
    command="curl -s cht.sh/$selected~$query | less"
fi

tmux split-window -p 33 -h bash -c "$command"
