#!/bin/bash

. ~/.homesick/repos/homeshick/homeshick.sh

homeshick clone joshkel/dotfiles
homeshick clone gmarik/vundle
homeshick clone jeffkaufman/icdiff

# gibrown fork is newer
#homeshick clone frankcortes/svn-stash
homeshick clone gibrown/svn-stash
