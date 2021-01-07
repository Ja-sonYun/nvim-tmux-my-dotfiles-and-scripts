#!/bin/zsh
echo $1
if [ "$1" == "" ]; then
    echo "Please set root directory"
    exit
fi
cp $HOME/.tmux/scripts/*.sh $1/tmux/scripts/
cp $HOME/.tmux.conf $1/tmux.conf

if [ "$2" == "nvim" ]; then
    cp -r $HOME/.config/nvim/ $1/nvim
fi

cd $1
git add .
git commit -m "committed via script"
git push
cd -
