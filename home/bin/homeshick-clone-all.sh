#!/bin/bash

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
clone joshkel/gtpp

# gibrown fork is newer.  Unfortunately, neither works well.
#clone frankcortes/svn-stash
clone gibrown/svn-stash
