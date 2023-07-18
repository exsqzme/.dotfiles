# https://www.freecodecamp.org/news/manage-multiple-python-versions-and-virtual-environments-venv-pyenv-pyvenv-a29fb00c296f/

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || _addToPathFront $PYENV_ROOT/bin
eval "$(pyenv init --path)"

# https://github.com/pyenv/pyenv-virtualenv
# enable auto-activation of virtualenvs
# eval "$(pyenv virtualenv-init -)"
alias pa='pyenv activate'
