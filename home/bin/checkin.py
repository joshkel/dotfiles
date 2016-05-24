#!/usr/bin/python
# Checks in any modified files at or below the current directory.
# Unlike running 'svn ci', this script will also handle relative externals
# within the current directory.

import re
import sys
from subprocess import call, PIPE, Popen

files = []

svn_st = Popen(['svn', 'st'], stdout=PIPE).communicate()[0]
for line in svn_st.split('\n'):
    status = line[0:4]
    file = line[4:].strip()
    if re.search('[MAD]', status):
        files.append(file)

args = ['svn', 'ci']
args.extend(sys.argv[1:])
args.extend(files)
call(args)
