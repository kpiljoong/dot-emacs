#!/bin/sh

function clone_repo() {
    DOT_DIR=$HOME/.emacs.d

    if [ -e $DOT_DIR ] ; then
	echo "Updating .dot-emacs"
	cd $DOT_DIR
	git pull
    else
	echo "Cloning .dot-emacs..."
	git clone https://github.com/kpiljoong/dot-emacs.git $DOT_DIR
	cd $DOT_DIR
    fi
}



clone_repo

exit 0
