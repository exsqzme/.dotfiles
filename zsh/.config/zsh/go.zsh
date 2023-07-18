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

