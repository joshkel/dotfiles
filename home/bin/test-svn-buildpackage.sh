#!/bin/bash
# Tests building a package that's maintained by svn-buildpackage by copying
# it to a temporary directory and building it "manually" from there.

set -e

mkdir -p tmp
rm -rf tmp/trunk
cp -a trunk tmp
cd tmp/trunk
debuild -us -uc -b

