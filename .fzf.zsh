# Setup fzf
# ---------
export FZF_DEFAULT_COMMAND='rg -g ""'
if [[ ! "$PATH" == *~/.fzf/bin* ]]; then
  export PATH="$PATH:~/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "~/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
#source "~/.fzf/shell/key-bindings.zsh"
source ~/.fzf/shell/key-bindings.zsh
