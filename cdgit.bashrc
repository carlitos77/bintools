# Change dir to closest containing a .git repo
#
# usage:    cdgit
#           
#
# INSTALLATION
#
# Source it from .bashrc
#
# es. by adding this line:
#   . ~/bin/cdgit.bashrc
#


function cdgit() {
    TESTDIR=$(pwd)

    while [ "$TESTDIR" != "/" ]
    do
        TESTME="$TESTDIR/.git"

        if [ -d $TESTME -o -f $TESTME ]
        then
            cd $TESTDIR
            break
        fi

        TESTDIR=$(dirname $TESTDIR)
    done
}

# alias cdg
alias cdg="cdgit"
