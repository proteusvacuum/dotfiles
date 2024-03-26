# export DJANGO_PROJECT_ROOT=$PROJECTS/dimagi/commcare-hq
# export PYTHONPATH=$DJANGO_PROJECT_ROOT:$DJANGO_PROJECT_ROOT/corehq/ex-submodules

# for MODULE in `ls $DJANGO_PROJECT_ROOT/submodules`
# do
#     export PYTHONPATH=$PYTHONPATH:$DJANGO_PROJECT_ROOT/submodules/$MODULE
# done
export PATH="$HOME/.virtualenvs/system/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
