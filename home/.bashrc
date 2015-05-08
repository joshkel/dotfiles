# If not running interactively, don't do anything
# Comment out for now; having non-interactive aliases is useful
#[[ "$-" != *i* ]] && return

# Shell Options

# Don't wait for job termination notification
set -o notify

# For more bash history options, see http://unix.stackexchange.com/q/1288,
# http://stackoverflow.com/questions/103944
shopt -s histappend
export HISTCONTROL=ignoredups
export HISTIGNORE=" *"
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export FIGNORE=.svn

# Keep VT-100 line-drawing characters ("lqqqk") from showing up in PuTTY.
# http://stackoverflow.com/q/8483798/25507, http://superuser.com/q/278286/4160
export NCURSES_NO_UTF8_ACS=1

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Customize prompt.  Based on Debian's .bashrc.
#if [ $(uname) == 'Linux' ]; then
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
cygwin)
    PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" -a -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
fi

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

alias ls='ls -hF --color=tty'                 # classify files in colour
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias please='sudo !!'

alias vless=/usr/share/vim/vim[0-9]*/macros/less.sh
if [[ $(uname) == Darwin ]]; then
    alias gvim=mvim
fi

# Windows, Cygwin, Embarcadero RAD Studio
if [[ $(uname) != Darwin && $(uname -o) == Cygwin ]]; then
    export cygPROGRAMFILES='/cygdrive/c/Program Files (x86)'
    alias cdapp='cd /cygdrive/c/trunk/app'
    alias cdcg='cd "$cygPROGRAMFILES/Embarcadero/RAD Studio/11.0"'
    alias cdinc='cd "$cygPROGRAMFILES/Embarcadero/RAD Studio/11.0/include"'
    alias cdsrc='cd "$cygPROGRAMFILES/Embarcadero/RAD Studio/11.0/source"'

    alias gvim="HOME=$(cygpath \"$HOMEDRIVE$HOMEPATH\") cmd /c gvim"
fi

export EDITOR=vim
export SVN_EDITOR=vim
export PATH=$PATH:~/bin
export LUA_CPATH=";;/usr/local/lib/lua/5.1/?.so"
export GCC_COLORS=1

# ack is known as ack-grep on Debian / Ubuntu
if ! which ack >& /dev/null; then
    alias ack=ack-grep
fi

# make
if which colormake >& /dev/null; then
    alias make=colormake
fi
# See http://blog.jgc.org/2015/04/the-one-line-you-should-add-to-every.html
alias dbgmake="\\make -f~/bin/Makefile.debug"

if [ -x /usr/local/eclipse/eclipse ]; then
    alias eclipse=/usr/local/eclipse/eclipse
fi

alias schroot='schroot -p'

# ack aliases
alias cgrep='ack --cc --cpp'
alias hgrep='ack --hh'
alias jgrep='ack --java'
alias plgrep='ack --perl'
alias pygrep='ack --python'
alias phpgrep='ack --php'
alias rbgrep='ack --ruby'

alias histgrep='history | grep'

# Ruby Gems
if [ -d $HOME/gems ]; then
    export GEM_HOME=$HOME/gems
    export GEM_PATH=$HOME/gems:/usr/lib/ruby/gems/1.8/
    export PATH=$HOME/gems/bin:$PATH
fi

# Python
export PYTHONSTARTUP=~/.pythonrc
alias pyenv='source ~/pyenv/bin/activate'

# Enable programmable completion.  May already be done in /etc/bash.bashrc.
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if which brew >& /dev/null; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

# On OS X, use GNU stuff instead of OS X stuff, courtesy of Homebrew.
if [ -d /usr/local/opt/findutils ]; then
    alias find=gfind
fi

# Based on http://mmb.pcb.ub.es/~carlesfe/unix/tricks.txt:
function lt() { ls -ltra "$@" | tail; }
function psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; }
function fname() { find . -iname "*$@*"; }

# From http://fredkschott.com/post/2014/02/git-log-is-so-2005/
# git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

function lookuperror
{
    cpp -dM /usr/include/errno.h | grep -w "$@"
    perl -MPOSIX -e 'print strerror($ARGV[0])."\n";' $@
}

export DEBFULLNAME="Josh Kelley"

# Make unit tests that use Google Test include time taken by default.
export GTEST_PRINT_TIME=1

# Additional development stuff
if [ -f ~/trunk/app/scripts/dev.bashrc ]; then
    . ~/trunk/app/scripts/dev.bashrc
fi

ulimit -c unlimited

SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

# Sample ssh-agent setup
#if [ -f "${SSH_ENV}" ]; then
#     . "${SSH_ENV}" > /dev/null
#     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#        start_agent;
#    }
#else
#    start_agent;
#fi


# Homeshick configuration. See the Homeshick tutorial.
# Skip this if we're running in a git-less chroot.
if which git >& /dev/null; then
    source "$HOME/.homesick/repos/homeshick/homeshick.sh"
    source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
    if [[ $- == *i* ]]; then
        homeshick --quiet refresh
    fi
fi

# Optional machine-specific aliass
test -f ~/.bashrc.local && . ~/.bashrc.local
