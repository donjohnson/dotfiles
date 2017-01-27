HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=10000000
#TODO set up histfile rotation >2000 lines

setopt appendhistory autocd extendedglob notify

zstyle :compinstall filename '/Users/djoh68/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# ls colors
autoload -U colors && colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Enable ls colors
if [ "$DISABLE_LS_COLORS" != "true" ]
then
  # Find the option for using colors in ls, depending on the version: Linux or BSD
  if [[ "$(uname -s)" == "NetBSD" ]]; then
    # On NetBSD, test if "gls" (GNU ls) is installed (this one supports colors);
    # otherwise, leave ls as is, because NetBSD's ls doesn't support -G
    gls --color -d . &>/dev/null 2>&1 && alias ls='gls --color=tty'
  elif [[ "$(uname -s)" == "OpenBSD" ]]; then
    # On OpenBSD, "gls" (ls from GNU coreutils) and "colorls" (ls from base,
    # with color and multibyte support) are available from ports.  "colorls"
    # will be installed on purpose and can't be pulled in by installing
    # coreutils, so prefer it to "gls".
    gls --color -d . &>/dev/null 2>&1 && alias ls='gls --color=tty'
    colorls -G -d . &>/dev/null 2>&1 && alias ls='colorls -G'
  else
    ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
  fi
fi

#setopt no_beep
setopt auto_cd
setopt multios
setopt cdablevars

if [[ x$WINDOW != x ]]
then
    SCREEN_NO="%B$WINDOW%b "
else
    SCREEN_NO=""
fi

# Apply theming defaults
PS1="mbp:%~ %# "

# git theming default: Variables for theming the git info prompt
ZSH_THEME_GIT_PROMPT_PREFIX="git:("         # Prefix at the very beginning of the prompt, before the branch name
ZSH_THEME_GIT_PROMPT_SUFFIX=")"             # At the very end of the prompt
ZSH_THEME_GIT_PROMPT_DIRTY="*"              # Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_CLEAN=""               # Text to display if the branch is clean

# Setup the prompt with pretty colors
setopt prompt_subst

# from http://dougblack.io/words/zsh-vi-mode.html
#bindkey -v

[[ -z "$terminfo[kcuu1]" ]] || bindkey "^[[A" up-line-or-history #"$terminfo[kcuu1]" up-line-or-history
[[ -z "$terminfo[kcud1]" ]] || bindkey "^[[B" down-line-or-history #""$terminfo[kcud1]" down-line-or-history

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$EPS1" #$(git_custom_status)
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/djoh68/.local/lib/aws/bin:/Users/djoh68/nike/bin

# aliases and helper functions
alias ll='ls -ltr'
alias history='history 1'
#alias hrep='history 1|grep '

function hrep () {
 if [ "$1" ]
 then
   fc -l 1|grep "$1" -
 fi
}

alias gits='git status'
alias gita='git add'
alias gitb='git branch'

#TODO integrate this with geeknote/evernote
function note () {
  if [ "$1" ]
  then
    filename="`date +%Y-%m-%d`_$1"
  else
    filename="temp_`date +%Y-%m-%d`_$RANDOM"
  fi
  echo -e "\033]50;SetProfile=Note\a"
  vim ~/nike/notes/${filename}.txt
}
