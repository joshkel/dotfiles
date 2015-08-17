#!/bin/bash

. ~/.homesick/repos/homeshick/homeshick.sh

homeshick clone joshkel/dotfiles
homeshick clone gmarik/vundle

# gibrown fork is newer
#homeshick clone frankcortes/svn-stash
homeshick clone gibrown/svn-stash
