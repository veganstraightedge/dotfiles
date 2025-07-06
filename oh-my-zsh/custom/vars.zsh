# shell vars
export EDITOR="zed -w"
export PROMPT_COMMAND="history -a"
export GIT_SSH="/usr/bin/ssh"
export MANPATH="/usr/local/git/man:$MANPATH"
export PGGSSENCMODE="disable"

# shell prompt
export PS1='\[\033]0;\w\007\][`git branch 2>&1 | grep "*" | cut -c3-`] \w: '

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/s/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH
