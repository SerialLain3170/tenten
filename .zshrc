
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#
autoload -U compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' use-cache true
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"

export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

autoload -Uz zmv
alias zmv='noglob zmv -W'

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=600000
setopt hist_ignore_dups
setopt share_history

## hisotry search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N hisotry-beginning-search-forward-end hisotry-search-end
bindkey "^P" hisotry-beginning-search-backward-end
bindkey "^N" hisotry-beginning-search-forward-end
#setopt APPEND_HISTORY
## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

# autoload -U colors
#colors
#
setopt auto_pushd
setopt correct
setopt list_packed
setopt auto_cd
setopt prompt_subst

# alias
alias -s py=python
alias gs="git status"

function extract() {
    case $1 in
      *.tar.gz|*.tgz) tar xzvf $1;;
      *.tar.xz) tar Jxvf $1;;
      *.zip) unzip $1;;
      *.lzh) lha e $1;;
      *.tar.bz2|*.tbz) tar xjvf $1;;
      *.tar.Z) tar zxvf $1;;
      *.gz) gzip -d $1;;
      *.bz2) bzip2 -dc $1;;
      *.Z) uncompress $1;;
      *.tar) tar xvf $1;;
      *.arj) unarj $1;;
    esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/cli/macro.sh

. $HOME/.asdf/asdf.sh
function peco-src () {
  local selected_dir=$(ghq list -p | peco --prompt="repositories >" --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

source ~/.zsh/.git-prompt.sh

fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
autoload -Uz compinit && compinit

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

PROMPT='%B%K{blue}%n@%m:$(echo ${${:-/${(j:/:)${(M)${(s:/:)${(D)PWD:h}}#(|.)[^.]}}/${PWD:t}}//\/~/\~})%#%k%K{red}$(__git_ps1 "(%s)")%k > %b'

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
