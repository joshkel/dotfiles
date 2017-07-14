#!/bin/bash

# shellcheck disable=SC1090
. ~/.homesick/repos/homeshick/homeshick.sh

function clone() {
    repo=$1
    if [ -d ~/.homesick/repos/"$(basename "$repo")" ]; then
        echo "$repo already exists, skipping..."
        return
    fi
    homeshick clone "$repo"
}

clone joshkel/dotfiles
clone gmarik/vundle
clone jeffkaufman/icdiff
clone jimeh/git-aware-prompt
clone jimeh/tmux-themepack
clone joshkel/gtpp

# gibrown fork is newer.  Unfortunately, neither works well.
#clone frankcortes/svn-stash
clone gibrown/svn-stash

# Make sure that Homeshick sees the newly cloned repos as up to date.
homeshick pull
