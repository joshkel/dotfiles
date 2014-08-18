# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

# Include .bashrc if it exists
# See http://superuser.com/a/183980/4160
if [[ $- == *i* && -r ~/.bashrc ]]; then
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

# Sample of explicitly setting Java for Debian / Ubuntu.  Not needed.
#export JAVA_HOME=/usr/lib/jvm/java-6-sun

