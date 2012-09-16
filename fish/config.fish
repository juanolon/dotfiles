# load tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# PATH
#########################
if status --is-login
	for p in /usr/local/bin /usr/local/sbin $HOME/.android/tools $HOME/.config/fish/bin $HOME/.bin $HOME/.rvm/bin
		if test -d $p
			set PATH $p $PATH
		end
	end
end



# SOME ALIASES
#########################
alias mkdir 'mkdir -p'
alias c 'clear'

alias ls 'ls -GFh'
alias la 'ls -la'
alias ll 'ls -hl'

alias sshv 'bcvi --wrap-ssh -- '

alias vim '/Applications/MacVim.app/Contents/MacOS/Vim'
# alias vim 'mvim --remote-silent'
# alias vm 'mvim --remote-silent || mvim'
# alias gvim 'mvim --remote-silent || mvim'

alias '...' 'cd ../..'
alias 'cd..' 'cd ..'

#mysql
alias start_mysql 'sudo /usr/local/mysql/bin/mysqld_safe &'
# TODO: create starts function, wich execute lanchctl start|stop

# git
alias gd 'git diff'
alias gs 'git status'
alias gc 'git commit -m'
alias gA 'git add -A'
alias add 'git add'
alias push 'git push'
alias pull 'git pull'

alias ev 'e /Users/juanolon/dotfiles/vim/vimrc'
alias ef 'e /Users/juanolon/dotfiles/fish/config.fish'
alias eh 'e /etc/hosts'


# CONFIG
#########################
set -x EDITOR "vim"
set fish_greeting ""
set BROWSER open
set -gx GREP_OPTIONS --color=auto
set -gx GREP_COLOR '0;37;43' # red bg
set -gx LESS '-cx4MiR' # clear screen, tabstop=4, long prompt, smart ignorecase, accept colors
set -gx CDPATH '.'
set -g -x NODE_PATH "/usr/local/lib/node_modules"

# locale settings
set -x LC_CTYPE=en_US.UTF-8
set -x LC_ALL=en_US.UTF-8
set -x LANGUAGE=en_US.UTF-8
set -x LC_ALL=en_US.UTF-8

# FUNCTIONS
#########################
#nginx
function ngx_start -d "start nginx"
    sudo /usr/local/sbin/nginx
end

function ngx_stop -d "stop nginx"
    sudo /usr/local/sbin/nginx -s stop
end

function ngx_log -d "shows nginx log file"
    tail -f /var/log/nginx/error.log
end

function ngx_reload -d "relaod nginx"
    sudo /usr/local/sbin/nginx -s reload
end
