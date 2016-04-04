#!/bin/sh

mkdir $HOME/.config
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/nvim/dein

echo 'export XDG_CONFIG_HOME=$HOME/.config' >> $HOME/.bashrc

cp ../nvimrc $HOME/.config/nvim/init.vim
cp ../.bashrc $HOME/.bashrc
dein_dir = $HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim
git clone https://github.com/Shougo/dein.vim $dein_dir
