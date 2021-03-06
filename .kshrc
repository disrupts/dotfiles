# kshrc at $HOME/.kshrc ###########
# vim: nowrap fdm=marker

# to execute at launch add . ~/.kshrc to .profile as such
# > if [[ `basename $SHELL` == 'ksh' ]]; then
# >   export ENV=$HOME/.kshrc
# > fi

# Set history file ############### {{{1
export HISTFILE=$HOME/.ksh_history

# Set prompt (PS1) ############### {{{1
BLACK='\033[30m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
MAGENTA='\033[35m'
CYAN='\033[36m'
WHITE='\033[37m'
REALUSER=`whoami`
USERSYMBOL=$(if [[ $REALUSER == 'root' ]] then echo '#'; else echo '$'; fi)
USERCOLOR=$(if [[ $REALUSER == 'root' ]] then echo $RED; else echo $YELLOW; fi)
HOSTCOLOR=$YELLOW
MAINCOLOR=$CYAN
export PS1=$(print $USERCOLOR$REALUSER$HOSTCOLOR"@"`hostname`$MAINCOLOR" "$USERSYMBOL" ")
