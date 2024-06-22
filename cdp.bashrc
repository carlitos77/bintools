#!/bin/bash
#           
# A "cd" using bookmarks.
#
# Usage:
#
#   $ cdp
#       Print list of bookmarks.
#
#   $ cdp .
#       Add a bookmark to current path, prompting for bookmark name.
#
#   $ cdp <prefix>
#       Change current directory to the path of firs matching bookmark.
#
#
# INSTALL
#
# Source this file in your .bashrc
#
#


function cdp() {
    # project list file
    local CDPFILE=$HOME"/.cdprojects"

    # no arguments, print projects
    
    if [ $# -eq 0 ]
    then

        if [ -f $CDPFILE ] 
        then
            # list all projects
            # one project by line (format: project name followed by a space character and project directory, optional follow description )
            # - project name format: no spaces, all ascii alphanum,  
            # - skip comment lines starting with '#'
            awk '!/^\s*#/ && !/^\s*$/ { prefisso = $1 ; $1 = "" ; print prefisso "|" $0 }'  $CDPFILE | sort | column -t -s "|" 
            return 0
        fi
    fi 
    
    # !!! one argument only
     
    if [ $# -gt 1 ]
    then
        echo "cdp too many arguments"
        return 1
    fi

    # unallowed arg ".." 
    if [ "$1" = ".." ]
    then
        return 1
    fi

function _cdp_tool {
    echo "passato - " $1
    echo "CDPFILE ??? " $CDPFILE
    return 1
}

    #_cdp_tool $1
    #echo "tool result " $?
    #local XOUT=$(_cdp_tool $1)
    #echo "tool out --- "$?":  $XOUT"

    if [ "$1" = "-e" ]
    then

        # edit projects file

        # FIXME handling editor variable
        vi $CDPFILE

    elif [ "$1" = "." ]
    then

        # add current dir in project list

        local NEWPDIR=$(pwd)

        local NEWP=$(basename $NEWPDIR)

        local READNAME
        echo "Project name for directory $NEWPDIR"
        read -e -i "$NEWP" READNAME
        READNAME=$(echo $READNAME | sed 's/ .*//')

        if [ "$READNAME" = "" ]
        then
            return 1
        fi

        if grep --quiet "^$READNAME\s" $CDPFILE
        then
            echo "ERROR Project name found, not updated."
            return 1
        fi

        echo "$READNAME $NEWPDIR" >>$CDPFILE

    else

        # change to project directory

        # a substring of project name
        local PATTERN="^$1"
        local CDPTO=$(awk -v pattern="$PATTERN" '!/^\s#/ && $0 ~ pattern { print $2 ; exit; }' ${CDPFILE}) 

        if [ -d $CDPTO ]
        then
            cd $CDPTO    
        else

            echo "cdp directory not found: $CDPTO"
            return 1
        fi
    fi
} ########################## !!!
###### ??? not working
###
### _cdp_completion() {
###     local _opts=$(cdp | sed 's/ .*//')
### 
###     local cur prev opts
###     COMPREPLY=()
###     cur="${COMP_WORDS[COMP_CWORD]}"
###     prev="${COMP_WORDS[COMP_CWORD-1]}"
###     opts="-e -p --help "
### 
###     if [ "$cur" = "." ]
###     then
###         #COMPREPLY=( ". : add current directory as a cdp project bookmark\n" "-e : edit project list file\n" )
###         echo -e "\nAdd current directory as a cdp project bookmark"
###         return 0
###     elif [[ ${cur} == -* ]] ; then
###         COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
###         return 0
###     fi
### 
### }
### complete -F _cdp_completion cdp
