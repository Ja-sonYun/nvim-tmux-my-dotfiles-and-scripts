#!/bin/zsh

DIR=`pwd`
cp $DIR/tmux.conf $HOME/.tmux.conf
cp $DIR/tmux/scripts/*.sh $HOME/.tmux/scripts/

if [ "$1" == "nvim" ]; then
    cp -r $DIR/nvim/ $HOME/.config/
fi
