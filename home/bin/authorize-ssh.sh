#!/bin/bash

set -e

< ~/.ssh/id_rsa.pub ssh -o StrictHostKeyChecking=no "$1" 'umask 077 && mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
