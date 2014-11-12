#!/bin/sh

ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.gvimrc ~/.gvimrc
ln -sf $PWD/.vim ~/.vim
sudo apt-get install -y curl
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

