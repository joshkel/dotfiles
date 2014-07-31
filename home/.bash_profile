# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi
PATH=~/perl:~/python:"${PATH}":/sbin:/usr/sbin

# On OS X, use GNU stuff instead of BSD stuff, courtesy of Homebrew.
if [ -d /usr/local/opt/coreutils ]; then
    export PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH
    export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
fi

#JAVA_HOME=/usr/lib/jvm/java-6-sun
#export JAVA_HOME

