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

ln -sf vimrc $HOME/.vimrc
ln -sf gvimrc $HOME/.gvimrc

if [ ! -e $HOME/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

vim +VundleInstall +qall
