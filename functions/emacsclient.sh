#!/bin/bash
set -e

export $PROJECTS=/home/farid/dev/
source /home/farid/.dotfiles/python/path.zsh
source /home/farid/.virtualenvs/cchq/bin/activate
cd $PROJECTS/dimagi/commcare-hq
emacs --daemon
