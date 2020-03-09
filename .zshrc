# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=20000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/u103922428/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

case "${TERM}" in
  ?term*|rxvt*|screen) PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME:=$(hostname)}: ${PWD/$HOME/"~"}\007"';;
esac
precmd() {eval "${PROMPT_COMMAND}"}

autoload -Uz colors
colors

PROMPT="%{${fg_bold[cyan]}%} %~%{${reset_color}%} %{${fg_bold[white]}%}$ %{${reset_color}%}"

eval $(dircolors ~/.dircolors-solarized/dircolors.ansi-universal)
alias ls="ls --color"

#
# History
#
# Share history between terminals
setopt share_history
# Ignore a command already is in the history
setopt hist_ignore_all_dups
# History key binds
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

#
# Completion
#
# Enable select menu
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${LS_COLORS}"
setopt always_last_prompt

# for pyenv by mnr 2020/02/17
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval 
eval "$(pyenv virtualenv-init -)"

# for directory navigation
# https://leahneukirchen.org/blog/archive/2012/02/10-new-zsh-tricks-you-may-not-know.html
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
DIRSTACKSIZE=9
DIRSTACKFILE=~/.zdirs
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

# for go lang by mnr 2020/03/02
export PATH=$PATH:/usr/local/go/bin
