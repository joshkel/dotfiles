#!/bin/bash
# Sets up per-user Python Pip packages.  Written for Ubuntu 14.04; newer
# distros are untested.  Ubuntu 14.04's pip is quite old, so some extra work
# is needed.

set -e

rm -rf ~/.local

# Newer appdirs and packaging are required to install other packages.  (In
# fact, not updating them can break the entire per-user Python installation.)
packages="appdirs packaging"

# A good REPL is always useful.
packages="ipython $packages"

# My linter of choice.
packages="flake8 $packages"

/usr/bin/pip2 install --user -U pip
~/.local/bin/pip2 install --user -U appdirs ipython packaging

/usr/bin/pip3 install --user -U pip packaging
~/.local/bin/pip3 install --user -U appdirs ipython packaging
