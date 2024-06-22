# bintools

A set of command line tools.

## cdp

Shortcut cd to directory.
Saved shortcuts are in file ~/.cdprojects.

Usage:

    $ cdp                       # print list of shortcut
    $ cdp .                     # add current dir to shortcut list
    $ cdp <prefix_string>       # cd to shortcut dir

### Installation

Source the cdp.bashrc file in your .bashrc

## cdg

cd to the first anchestor directory containing .git.

Usage:

    $ cdg

### Installation

Source the cdg.bashrc file in your .bashrc.

## git-cip

Commit all modified files in repo and push to remote.

Usage:

    $ git cip [message]

## seddar

Search and replace a string in all files under current directory.

Usage:

    $ seddar "search_string" "replace_string"
