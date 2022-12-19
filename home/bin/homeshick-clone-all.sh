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

# gibrown fork is newer.  Unfortunately, neither works well.
#clone frankcortes/svn-stash
# clone gibrown/svn-stash

####
# C++
clone joshkel/gtpp

# Not currently used
# clone mbalabin/Boost-Pretty-Printer

####
# PHP
# Not currently used
# clone DexterHD/codecept-bash-completion

####
# Finish

# Make sure that Homeshick sees the newly cloned repos as up to date.
homeshick pull
