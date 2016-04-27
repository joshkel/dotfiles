#!/bin/bash

. ~/.homesick/repos/homeshick/homeshick.sh

homeshick clone joshkel/dotfiles
homeshick clone gmarik/vundle
homeshick clone jeffkaufman/icdiff
homeshick clone jimeh/git-aware-prompt

# gibrown fork is newer.  Unfortunately, neither works well.
#homeshick clone frankcortes/svn-stash
homeshick clone gibrown/svn-stash
