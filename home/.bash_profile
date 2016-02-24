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

export NPM_PACKAGES="$HOME/.npm-packages"
export NODE_PATH="$NODE_PATH:$HOME/.npm-packages/lib/node_modules"

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi
export PATH=~/perl:~/python:"$NPM_PACKAGES/bin":"${PATH}":/sbin:/usr/sbin

# May want to add "$NPM_PACKAGES/share/man" to MANPATH

# On OS X, use GNU stuff instead of BSD stuff, courtesy of Homebrew.
if [ -d /usr/local/opt/coreutils ]; then
    export PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH
    export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
fi

if [ -d /Applications/Postgres.app ]; then
    export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
fi

# Added by the Heroku Toolbelt
export PATH="$PATH:/usr/local/heroku/bin"

# Sample of explicitly setting Java for Debian / Ubuntu.  Not needed.
#export JAVA_HOME=/usr/lib/jvm/java-6-sun

