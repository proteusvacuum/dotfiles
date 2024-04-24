alias djm='python manage.py'
alias djserve='python manage.py runserver_plus 0.0.0.0:8000 --keep-meta-shutdown'
alias djshell='python manage.py shell_plus'
alias djt='REUSE_DB=1 python manage.py test -s'

alias whq='pyenv activate hq && cd ~/dev/dimagi/commcare-hq'

alias wocs='pyenv activate ocs && cd ~/dev/dimagi/open-chat-studio'

alias wil='pyenv activate idealist && cd ~/dev/idealist/idealist'
alias istart='wil && ./bin/scripts/docker/compose up'
alias idt='./bin/scripts/docker/compose run --rm tester python runtests.py --verbose -s'
alias ifailed='./bin/scripts/docker/compose run --rm --no-deps tester python runtests.py --verbose $(bin/scripts/failed)'
