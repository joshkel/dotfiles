#!/bin/bash
#
# Installs an SSH key to a remote system.
#
# Your system probably provides an ssh-copy-id command that does more or less
# the same thing.

set -e

< ~/.ssh/id_rsa.pub ssh -o StrictHostKeyChecking=no "$1" 'umask 077 && mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && (if command -v restorecon; restorecon -R ~; fi )'
