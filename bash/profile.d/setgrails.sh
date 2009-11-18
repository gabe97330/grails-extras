#!/bin/bash
# modified from set_mvn which is modified from setjdk

function defaultgrails {
    local grailsdir=$GRAILS_PARENT
    local ver=${1?Usage: defaultgrails <version>}
    local grailsprefix=grails-

    [ -z "$2" ] || error="Too many arguments"
    [ -d $grailsdir/$grailsprefix$ver ] || local error="Unknown Grails version: $ver"
    [ "$(readlink $grailsdir/grails)" != "$grailsdir/$grailsprefix$ver" ] || local error="Default Grails already set to $ver"

    if [ -n "$error" ]; then
    echo $error
    return 1
    fi

    echo "Setting default Grails to $ver ... "

    if [ "$(/usr/bin/id -u)" != "0" ]; then
    SUDO=sudo
    fi

    $SUDO /bin/rm $grailsdir/grails
    $SUDO /bin/ln -s $grailsdir/$grailsprefix$ver $grailsdir/grails

    echo Done.
}

function setgrails {
    local grailsdir=$GRAILS_PARENT
    local ver=${1?Usage: setgrails <version>}
    local grailsprefix=grails-

    [ -d $grailsdir/$grailsprefix$ver ] || {
    echo Unknown Grails version: $ver
    return 1
    }

    echo "Setting current Grails version to $ver ..."

    export GRAILS_HOME=$grailsdir/$grailsprefix$ver
    PATH=$(echo $PATH | tr ':' '\n' | grep -v $grailsdir/$grailsprefix | tr '\n' ':')
    export PATH=$GRAILS_HOME/bin:$PATH

    grails
}

function _setgrails_completion (){
    COMPREPLY=()

    local grailsdir=$GRAILS_PARENT
    local cur=${COMP_WORDS[COMP_CWORD]//\\\\/}
    local options=$(cd $grailsdir; ls -d -1 grails-* | awk '{match($0,"grails-.*"); print substr($0,8,RLENGTH-7)}' | tr '\n' ' ')

    COMPREPLY=($(compgen -W "${options}" ${cur}))
}

complete -F _setgrails_completion -o filenames setgrails
complete -F _setgrails_completion -o filenames defaultgrails
