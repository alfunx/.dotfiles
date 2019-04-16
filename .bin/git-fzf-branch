#!/usr/bin/env bash

fzf() {
    fzf-tmux -d 50% -- "$@"
}

# filter git-branch (including remote-tracking branches)

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    exit 1
fi

git branch --all --color \
    | grep -v HEAD \
    | sed 's#.* ##' \
    | sed 's#remotes/##' \
    | fzf +s -m +e --ansi --preview-window 'right:70%' \
    --preview 'git log --pretty=lo --graph --color --date=human {1} -- | head -200'
