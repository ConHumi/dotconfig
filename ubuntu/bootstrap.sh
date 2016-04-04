#!/bin/sh

mkdir $HOME/.config
mkdir -p $HOME/.config/nvim

echo 'export XDG_CONFIG_HOME=$HOME/.config' >> $HOME/.bashrc

cp ../nvimrc $HOME/.config/nvim/init.vim
cp ../.bashrc $HOME/.bashrc
