#!/usr/bin/env bash
# https://github.com/chubin/cheat.sh#programming-languages-cheat-sheets
selected=`curl cht.sh/:list 2>/dev/null | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

if [[ $selected = *":"* ]]; then
    nvim -c ":term ( echo \"curl cht.sh/$selected/\"; curl -fsSL cht.sh/$selected 2>/dev/null; )"
    # ( echo \"curl cht.sh/$selected/\"; curl -fsSL cht.sh/$selected 2>/dev/null; )| less -R
    # tmux neww bash -c "echo \"curl cht.sh/$selected/\" & curl cht.sh/$selected & while [ : ]; do sleep 1; done"
else
    read -p "Enter Query: " query

    # check if query is one word
    # or flag for list, learn, intro
    # +- for exclude word
    # number for question skip
    if [[ $query = *" "* ]]; then
        query=`echo $query | tr ' ' '+'`
        nvim -c ":term ( echo \"curl cht.sh/$selected/$query/\"; curl -fsSL cht.sh/$selected/$query 2>/dev/null; )"
        # ( echo \"curl cht.sh/$selected/$query/\"; curl -fsSL cht.sh/$selected/$query 2>/dev/null; ) | less -R
        # tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
    else
        nvim -c ":term ( echo \"curl cht.sh/$selected~$query/\"; curl -fsSL cht.sh/$selected~$query 2>/dev/null; echo \"curl cht.sh/$selected/$query/\"; curl -fsSL cht.sh/$selected/$query 2>/dev/null; )"
        # ( echo \"curl cht.sh/$selected~$query/\"; curl -fsSL cht.sh/$selected~$query 2>/dev/null; echo \"curl cht.sh/$selected/$query/\"; curl -fsSL cht.sh/$selected/$query 2>/dev/null; ) | less -R
        # tmux neww bash -c "echo \"curl cht.sh/$selected~$query/\" & curl -s cht.sh/$selected~$query & echo \"curl cht.sh/$selected/$query/\" & curl -s cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
    fi
fi
