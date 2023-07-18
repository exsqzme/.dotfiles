# ---------------------- local utility functions ---------------------
export XDG_CONFIG_HOME=$HOME/.config

_have()      { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }
_addToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

_addToPathFront() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}

_addToPathFront $HOME/.local/bin

# Detect the platform (similar to $OSTYPE)
OS="`uname`"
case $OS in
  "Linux")
    export OS="Linux"
    ;;
  "FreeBSD")
    export OS="FreeBSD"
    ;;
  "WindowsNT")
    export OS="Windows"
    ;;
  "Darwin")
    export OS="Mac"
    # Install GNU `sed`, overwriting the built-in `sed`.
    # brew install gnu-sed --with-default-names`
    # TODO: better way "symlink" or "brew link --force xxx"
    PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
    PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
    PATH="/usr/local/opt/fgrep/libexec/gnubin:$PATH"
    PATH="/usr/local/opt/egrep/libexec/gnubin:$PATH"
    PATH="/usr/local/opt/less/libexec/gnubin:$PATH"
    PATH="/usr/local/opt/libpq/bin:$PATH"
    PATH="/usr/local/opt/openjdk/bin:$PATH"

    ;;
  "SunOS")
    export OS="Solaris"
    ;;
  "AIX")
    export OS="Unknown"
    ;;
  *)
    export OS="Unknown"
    ;;
esac

. "$HOME/.cargo/env"
