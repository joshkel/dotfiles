#!/bin/bash
# shellcheck disable=1090,2034

# If not running interactively, don't do anything
# Comment out for now; having non-interactive aliases is useful
#[[ "$-" != *i* ]] && return


export NPM_PACKAGES="$HOME/.npm-packages"
export NODE_PATH="$NODE_PATH:$HOME/.npm-packages/lib/node_modules"

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi
export PATH="$NPM_PACKAGES/bin":~/.cabal/bin:${PATH}:/sbin:/usr/sbin

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


# Shell Options

# Don't wait for job termination notification
set -o notify

export FIGNORE=.svn

# Automatically trim long paths in the prompt
export PROMPT_DIRTRIM=2

# Keep VT-100 line-drawing characters ("lqqqk") from showing up in PuTTY.
# http://stackoverflow.com/q/8483798/25507, http://superuser.com/q/278286/4160
export NCURSES_NO_UTF8_ACS=1

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# From mrzool/bash-sensible:
# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null
# Case insensitive filename tab completion (particularly useful on Windows)
if [ -t 1 ]; then
    bind "set completion-ignore-case on"
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

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

# git-aware-prompt - https://github.com/jimeh/git-aware-prompt
export GITAWAREPROMPT=~/.homesick/repos/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

# Customize prompt.  Based on Debian's .bashrc.
# Also depends on git-aware-prompt
#if [ $(uname) == 'Linux' ]; then
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# shellcheck disable=2154
PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# For more bash history options, see http://unix.stackexchange.com/q/1288,
# http://stackoverflow.com/questions/103944
shopt -s histappend
export HISTCONTROL=ignoredups
export HISTIGNORE=" *"
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
# Write and read history on every command
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# Record each command as it gets issued
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" -a -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
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

alias tmux='tmux -2'

# Fix SSH forwarding within tmux.  https://stackoverflow.com/a/40967729/25507
alias fixssh='export $(tmux showenv SSH_AUTH_SOCK)'

alias vless=/usr/share/vim/vim[0-9]*/macros/less.sh
if [[ $(uname) == Darwin ]]; then
    alias gvim=/Applications/MacVim.app/Contents/bin/mvim
fi

. ~/.homesick/repos/dotfiles/home/bin/upto.sh

# man
# See also https://www.reddit.com/r/programming/comments/4xyvoe/colorized_man_pages/
#if which most >& /dev/null; then
#    export MANPAGER=most
#fi
export MANPAGER=~/bin/vimmanpager

# Common directories
shopt -s cdable_vars
if [ -d /cygdrive/c/trunk/app ]; then
    app=/cygdrive/c/trunk/app
elif [ -d /c/trunk/app ]; then
    app=/c/trunk/app
elif [ -d ~/trunk/app ]; then
    app=~/trunk/app
fi

# Windows, Cygwin, Embarcadero RAD Studio
if [[ $(uname) != Darwin && $(uname -o) == Cygwin ]]; then
    export cygPROGRAMFILES='/cygdrive/c/Program Files (x86)'
    alias cdcg='cd "$cygPROGRAMFILES/Embarcadero/Studio/19.0"'
    alias cdinc='cd "$cygPROGRAMFILES/Embarcadero/Studio/19.0/include"'
    alias cdsrc='cd "$cygPROGRAMFILES/Embarcadero/Studio/19.0/source"'

    alias gvim="HOME=$(cygpath \"$HOMEDRIVE$HOMEPATH\") cmd /c gvim"
fi

export EDITOR=vim
export SVN_EDITOR=vim
export PATH=$PATH:~/bin
export LUA_CPATH=";;/usr/local/lib/lua/5.1/?.so"
export GCC_COLORS=1

# ack is known as ack-grep on Debian / Ubuntu.
# But ag is even better.
if which ag >& /dev/null; then
    alias ack=ag
elif ! which ack >& /dev/null; then
    alias ack=ack-grep
fi

# make
# Disable for now, since g++ added its own color support.
#if which colormake >& /dev/null; then
#    alias make=colormake
#fi
# See http://blog.jgc.org/2015/04/the-one-line-you-should-add-to-every.html
alias dbgmake="\\make -f~/bin/Makefile.debug"

if [ -x /usr/local/eclipse/eclipse ]; then
    alias eclipse=/usr/local/eclipse/eclipse
fi

alias schroot='schroot -p'
if [ -f /usr/bin/schroot ]; then
    for f in /srv/chroot/*; do
        CHROOT=$(basename "$f")
        alias $CHROOT="schroot -c ${CHROOT}"
    done
    unset CHROOT
fi

# ack aliases
alias cgrep='ack --cc --cpp'
alias hgrep='ack --hh'
alias jgrep='ack --java'
alias plgrep='ack --perl'
alias pygrep='ack --python'
alias phpgrep='ack --php'
alias rbgrep='ack --ruby'

alias histgrep='history | grep'


# Vagrant
# See https://www.vagrantup.com/docs/other/wsl.html
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS=1

# C++
export GTEST_RUNNER="~/.homesick/repos/gtpp/gtpp.py --failures-only"

# Ruby Gems
if [ -d "$HOME/gems" ]; then
    export GEM_HOME=$HOME/gems
    export GEM_PATH=$HOME/gems:/usr/lib/ruby/gems/1.8/
    export PATH=$HOME/gems/bin:$PATH
fi


# Python
export PYTHONSTARTUP=~/.pythonrc

# Python packages installed via `pip install --user`
# See https://stackoverflow.com/a/38112757/25507
python_site_dir=$(python3  -c "import site; print(site.USER_BASE)" 2>/dev/null)
if [ ! -z "$python_site_dir" ]; then
    export PATH=$python_site_dir/bin:$PATH
fi
unset python_site_dir

# Manually managed virtualenv:
#alias pyenv='source ~/pyenv/bin/activate'

# Using pyenv:
if which pyenv >& /dev/null; then eval "$(pyenv init -)"; fi

#To activate *everything*:
#pyenv shell system 2.7.10 3.3.6 3.2.6 3.1.5 2.6.9 2.5.6 pypy-c-jit-latest

#To use Homebrew's directories rather than ~/.pyenv add to your profile:
#export PYENV_ROOT=/usr/local/var/pyenv


# Ruby
# rbenv was installed using
#   git clone https://github.com/rbenv/rbenv.git ~/.rbenv
#   cd ~/.rbenv && src/configure && make -C src
#   git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
if [ -d ~/.rbenv/bin ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

alias be='bundle exec'


# Subversion
# From frankcortes/svn-stash:
alias svn-stash='python ~/.homesick/repos/svn-stash/svn-stash.py'
alias svn-icdiff='svn diff --diff-cmd=icdiff'

# Enable programmable completion.  May already be done in /etc/bash.bashrc.
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if which brew >& /dev/null; then
    if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
        . "$(brew --prefix)/etc/bash_completion"
    fi
fi
. ~/bin/django_bash_completion

# On OS X, use GNU stuff instead of OS X stuff, courtesy of Homebrew.
if [ -d /usr/local/opt/findutils ]; then
    alias find=gfind
fi

# See http://superuser.com/a/975878/4160
alias brewski='brew update && brew upgrade --all && brew cleanup; brew doctor'

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


# Homeshick configuration. See the Homeshick tutorial.
# Skip this if we're running in a git-less chroot.
if which git >& /dev/null; then
    source "$HOME/.homesick/repos/homeshick/homeshick.sh"
    source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
    if [[ $- == *i* ]]; then
        homeshick --quiet refresh
    fi
fi

# -- Improved X11 forwarding through GNU Screen (or tmux).
# If not in screen or tmux, update the DISPLAY cache.
# If we are, update the value of DISPLAY to be that in the cache.
# Source: http://alexteichman.com/octo/blog/2014/01/01/x11-forwarding-and-terminal-multiplexers/
function update_x11_forwarding() {
    if [ -z "$STY" -a -z "$TMUX" ]; then
        echo $DISPLAY > ~/.display.txt
    else
        local new_display=$(cat ~/.display.txt)
        if [ ! -z "$new_display" ]; then
            export DISPLAY=$new_display
        fi
    fi
}

PROMPT_COMMAND="update_x11_forwarding; $PROMPT_COMMAND"

# Optional machine-specific aliases
test -f ~/.bashrc.local && . ~/.bashrc.local

# Sample Powerline configuration.  This assumes that you ran
# pip3 install --user powerline-status
# For this to look okay in PuTTY, you need to install and configure
# https://github.com/Determinant/inconsolata_for_powerline_mod
#if which powerline-daemon >& /dev/null; then
#    powerline-daemon -q
#    POWERLINE_BASH_CONTINUATION=1
#    POWERLINE_BASH_SELECT=1
#    . $(python3 -m site --user-site)/powerline/bindings/bash/powerline.sh
#fi
