#!/bin/sh

echo "Running ${0##*/}... " 

if [ ! -d $HOME/.vim/bundle ]; then
    mkdir $HOME/.vim/bundle
fi

cd $HOME/.vim

if [ -e $HOME/.vimrc_bak ]; then
    echo "rm $HOME/.{,g}vimrc_bak" 
    rm $HOME/.{,g}vimrc_bak
fi


if [ -e $HOME/.vimrc ]; then mv $HOME/.vimrc{,_bak}; fi
if [ -e $HOME/.gvimrc ]; then mv $HOME/.gvimrc{,_bak}; fi

ln -sf $PWD/vimrc $HOME/.vimrc
ln -sf $PWD/gvimrc $HOME/.gvimrc

if [ ! -e $HOME/.vim/autoload/plug.vim ]; then
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugInstall
