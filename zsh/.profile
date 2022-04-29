# {{{ Go
if [ -d /usr/local/go/bin/ ]; then
  export GOPATH=~/dev/go
  export GOBIN="$GOPATH/bin"
  _addToPathFront $GOBIN
  _addToPathFront /usr/local/go/bin
elif [ -d ~/.go/bin/ ]; then
  export GOPATH="$HOME/.gopath"
  export GOROOT="$HOME/.go"
  export GOBIN="$GOPATH/bin"
  _addToPathFront $GOPATH/bin
fi

# {{{ Rust
_addToPathFront $HOME/.cargo/bin

# {{{ Volta (node / yarn)
export VOLTA_HOME="$HOME/.volta"
_addToPathFront $VOLTA_HOME/bin

# {{{ Pyenv
export PYENV_ROOT="$HOME/.pyenv"
_addToPathFront $PYENV_ROOT/bin
eval "$(pyenv init --path)"
