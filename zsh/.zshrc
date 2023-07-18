## ZSH options
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
# setopt CORRECTALL
# ENABLE_CORRECTION="true"

# If set, parameter expansion, command substitution and arithmetic expansion are performed in prompts. Substitutions within prompts do not affect the command status.
# setopt PROMPT_SUBST

# When executing a shell function or sourcing a script, set $0 temporarily to the name of the function/script. Note that toggling FUNCTION_ARGZERO from on to off (or off to on) does not change the current value of $0. Only the state upon entry to the function or script has an effect. Compare POSIX_ARGZERO.
# setopt FUNCTION_ARGZERO

# https://github.com/jeffreytse/zsh-vi-mode
# Do the initialization when the script is sourced (i.e. Initialize instantly)
# allows the bindkeys to be set now, instead of later which messes personal bindkey settings up
ZVM_INIT_MODE=sourcing
# ZVM_VI_INSERT_ESCAPE_BINDKEY=kj

source $XDG_CONFIG_HOME/antigen/antigen.zsh

antigen bundle "zsh-users/zsh-syntax-highlighting"
antigen bundle "jeffreytse/zsh-vi-mode"
antigen bundle "zsh-users/zsh-autosuggestions"

antigen apply


eval "$(starship init zsh)"

source ~/.zsh_profile

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

bindkey '^ ' autosuggest-accept
# Need a second option ?? make sure accepts are aligned with how they
# work in nvim/cmp etc
# bindkey '^n' autosuggest-accept
bindkey '^y' autosuggest-accept

# Where should I put you?
bindkey -s ^f "tmux-sessionizer\n"

# https://rutar.org/writing/from-vim-and-tmux-to-neovim/

# TODO: Find a place for this
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
# alias nvim-kick="NVIM_APPNAME=kickstart nvim"
# alias nvim-chad="NVIM_APPNAME=NvChad nvim"
# alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

function nvims() {
  items=("default" "LazyVim" "NvChad" "AstroNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
