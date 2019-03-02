alias ls='ls -G'
alias ll='ls -l'
#fzf

frepo() {
	  local dir
	    dir=$(ghq list > /dev/null | fzf-tmux --reverse +m) &&
			    cd $(ghq root)/$dir
			}

function fcd() {
	    if [[ "$#" != 0 ]]; then
			builtin cd "$@";
			 return
		fi
		while true; do
			local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
			local dir="$(printf '%s\n' "${lsd[@]}" |
			fzf --reverse --preview '
			__cd_nxt="$(echo {})";
			__cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
			echo $__cd_path;
			echo;
			ls -p --color=always "${__cd_path}";
			')"
			[[ ${#dir} != 0 ]] || return 0
			builtin cd "$dir" &> /dev/null
		done
}

fshow() {
	git log --graph --color=always \
		--format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
		fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
		--bind "ctrl-m:execute:
		(grep -o '[a-f0-9]\{7\}' | head -1 |
		xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
		{}
		FZF-EOF"
}

fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#変数設定
#localectl set-locale LANG=ja_JP.UTF-8
source ~/internalShell/internal.sh
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=~/.local/bin/:$PATH
export ZPLUG_HOME=~/dotfiles/.zplug

# Customise the Powerlevel9k prompts
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S \uE868  %Y-%m-%d}"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon user dir vcs virtualenv)
POWERLEVEL9K_USER_DEFAULT_BACKGROUND="green"
POWERLEVEL9K_USER_DEFAULT_FOREGROUND="black"
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=7
POWERLEVEL9K_MODE='nerdfont-complete'
source ~/powerlevel9k/powerlevel9k.zsh-theme

# zplug
source ~/.zplug/init.zsh
# zplug settings
source $ZPLUG_HOME/init.zsh

# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting"

# history関係
zplug "zsh-users/zsh-history-substring-search"
# タイプ補完
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zplug "plugins/git",   from:oh-my-zsh
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load
