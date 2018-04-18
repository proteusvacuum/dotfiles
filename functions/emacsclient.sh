#!/bin/bash
set -e

source /home/farid/.virtualenvs/cchq/bin/activate
cd ~/dev/dimagi/commcare-hq
emacs --daemon
