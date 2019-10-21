#!/bin/bash

set -e

if [ -n "$1" ]; then
    when=$1
else
    weekday=$(date +%u)
    if [[ $weekday -eq 7 ]]; then
        # On Sunday, evaluate Friday and Saturday.
        when="2 days ago"
    elif [[ $weekday -eq 1 ]]; then
        # On Monday, evaluate Friday, Saturday, and Sunday.
        when="3 days ago"
    else
        when="1 days ago"
    fi
fi
since="$(date -d "$when" +%Y-%m-%d) 12:00:00am"

export GIT_PAGER=cat

if [ -t 1 ]; then
    view="view"
else
    view="cat"
fi

cd ~/src
$view <(for gitdir in */.git; do
    # Skip secondary git worktree directories
    if [ ! -d "$gitdir" ]; then continue; fi

    (cd "$(dirname "$gitdir")" &&
        git log --all --name-status --since="$since" --decorate --author=Kelley | perl -pe 's/ +$//')
done)
