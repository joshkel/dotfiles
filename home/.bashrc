# If not running interactively, don't do anything
# Comment out for now; having non-interactive aliases is useful
#[[ "$-" != *i* ]] && return

# Shell Options

# Don't wait for job termination notification
set -o notify

# For more bash history options, see http://unix.stackexchange.com/q/1288
shopt -s histappend
export HISTIGNORE=" *"

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

alias ls='ls -hF --color=tty'                 # classify files in colour

alias vless=/usr/share/vim/vim[0-9]*/macros/less.sh

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
export PATH=$PATH:~/bin
export LUA_CPATH=";;/usr/local/lib/lua/5.1/?.so"

# ack is known as ack-grep on Debian / Ubuntu
if ! which ack >& /dev/null; then
alias ack=ack-grep
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

# On OS X, use GNU stuff instead of OS X stuff, courtesy of Homebrew.
if [ -d /usr/local/opt/findutils ]; then
    alias find=gfind
fi

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

