# COLORS {{{
## set colors for GNU ls ; set this to right file
# TODO use the right theme
export LS_COLORS='*.swp=00;44;37:*,v=5;34;93:*.vim=35:no=0:fi=0:di=32:ln=36:or=1;40:mi=1;40:pi=31:so=33:bd=44;37:cd=44;37:ex=35:*.jpg=1;32:*.jpeg=1;32:*.JPG=1;32:*.gif=1;32:*.png=1;32:*.jpeg=1;32:*.ppm=1;32:*.pgm=1;32:*.pbm=1;32:*.c=1;32:*.C=1;33:*.h=1;33:*.cc=1;33:*.awk=1;33:*.pl=1;33:*.gz=31:*.tar=31:*.zip=31:*.lha=1;31:*.lzh=1;31:*.arj=1;31:*.bz2=31:*.tgz=31:*.taz=1;31:*.html=36:*.htm=1;34:*.doc=1;34:*.txt=1;34:*.o=1;36:*.a=1;36'
# }}}

# VARS {{{
export EDITOR='vim'
export VISUAL='vim'
# }}}

# Zsh to use the same colors as ls
# @TODO don't work
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#
# PATH {{{

export GOPATH="$HOME/gocode"

php55_path=`/usr/local/bin/brew --prefix josegonzalez/php/php55`
path=''
path=($path /usr/local/bin $HOME/.bin)
path=($path /bin /usr/bin /usr/sbin /sbin)
path=($path $HOME/.rvm/bin)
path=($path $HOME/.android/tools)
path=($path /usr/local/share/npm/bin/)
path=($path /usr/local/opt/coreutils/libexec/gnubin)
path=($path $php55_path/bin)
path=($path /usr/local/opt/go/libexec/bin)
path=($path $HOME/.composer/vendor/bin)
path=($path $GOPATH/bin)
path=($path $HOME/.depot_tools)
export PATH="$path":$PATH
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export JAVA_HOME=`/usr/libexec/java_home`

cdpath=(~ ..) ## on cd command offer dirs in home and one dir up.

NODE_PATH="/usr/local/lib/node_modules" # from bash..

manpath=($manpath /usr/share/man) ## EDIT ##
manpath=($manpath /usr/local/opt/coreutils/libexec/gnuman) ## EDIT ##

fpath=(/usr/local/share/zsh-completions $fpath)

## remove duplicate entries from path,cdpath,manpath & fpath
typeset -gU path cdpath manpath fpath #TODO
# }}}

# ALIASES {{{
# alias c='clear'
alias h='history'
alias vim='reattach-to-user-namespace /usr/local/Cellar/vim/HEAD/bin/vim'
# alias v='f -t -e vim -b viminfo'
alias ag='ag --color-line-number=91 --color-match=31 --color-path="34;103" -S'
alias agg='ag -g'
alias mv='nocorrect mv -i'
alias cp='nocorrect cp -i'
alias rm='nocorrect rm -i'
alias mkdir='nocorrect mkdir -p'
alias man='nocorrect man'
alias find='noglob find'
alias grep='grep --colour'
alias less='less -R'
# not necessary with prezto :prezto:module:gnu-utility
if [[ "$VENDOR" == "apple" ]]; then
    alias ls='gls -G --color=auto'
else
    alias ls='ls --color=auto'
fi
alias l='ls'
alias ll='ls -hl'
alias la='ls -al'
alias lsh='ls -ls .*' ## list only file beginning with "."
alias lsd='ls -ld *(-/DN)' ## list only dirs
alias c='fasd_cd -d'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias sshv='bcvi --wrap-ssh -- '
if [[ -n $TMUX ]]; then
    alias nvim='vim'
    v() { VIM_BIN='reattach-to-user-namespace vim' tvim "$@"; }
    alias pbcopy='reattach-to-user-namespace pbcopy'
    alias pbpaste='reattach-to-user-namespace pbpaste'
fi
alias :q='exit'

# git
alias gd='git diff'
alias gs='git status'
alias commit='git commit -m'
alias gA='git add -A'
alias add='git add'
alias push='git push'
alias pull='git pull'

alias tmux="TERM=xterm-256color tmux -u -2"

alias t='python ~/.bin/t --task-dir="~/notes/tasks" --list tasks'
alias tf='t -f'
alias tc='t | wc -l'
alias tree='tree -dCA -L 2'

alias json='jq'

## global aliases, this is not good but it's useful
alias -g L='|less'
alias -g G='|grep'
alias -g T='|tail'
alias -g H='|head'
alias -g W='|wc -l'
alias -g S='|sort'
alias -g UC='|uniq -c'
alias -g US='|sort -u'
alias -g NS='|sort -n'
alias -g RNS='|sort -nr'
alias -g N='&>/dev/null&'

#Show progress while file is copying

# Rsync options are:
#  -p - preserve permissions
#  -o - preserve owner
#  -g - preserve group
#  -h - output in human-readable format
#  --progress - display progress
#  -b - instead of just overwriting an existing file, save the original
#  --backup-dir=/tmp/rsync - move backup copies to "/tmp/rsync"
#  -e /dev/null - only work on local files
#  -- - everything after this is an argument, even if it looks like an option

alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"

# }}}

# CLI EDITING {{{
bindkey "^j" history-beginning-search-forward ## down arrow for fwd-history-search
bindkey "^k" history-beginning-search-backward ## up arrow for back-history-search
bindkey "^w" forward-word ## go forward one word
bindkey "^b" backward-word ## go back one word
bindkey "^d" backward-kill-word
bindkey "^h" backward-char
bindkey "^l" forward-char
bindkey '^v' fasd-complete    # C-x C-a to do fasd-complete (fils and directories)
# bindkey '^' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
# bindkey '^d' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)
bindkey '^4' end-of-line
bindkey '^0' beginning-of-line
# }}}

# DOCKER {{{
$(boot2docker shellinit)
# }}}
