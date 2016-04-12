#!/bin/sh

# # nvim configuration
# mkdir $HOME/.config
# mkdir -p $HOME/.config/nvim
# mkdir -p $HOME/.config/nvim/dein
# echo 'export XDG_CONFIG_HOME=$HOME/.config' >> $HOME/.bashrc

# cp ../nvimrc $HOME/.config/nvim/init.vim
# cp ../.dein.toml $HOME/.config/nvim/.dein.toml
# cp ../.dein_lazy.toml $HOME/.config/nvim/.dein_lazy.toml
# cp ../.bashrc $HOME/.bashrc
# dein_dir = $HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim
# git clone https://github.com/Shougo/dein.vim $dein_dir

# zsh の設定
# zsh がなければインストール
if [ ! `which zsh` ]; then
	brew install zsh	
	sudo echo "/usr/local/bin/zsh" >> /etc/shells
	chsh -s /usr/local/bin/zsh
fi

rm -f $HOME/.zshenv
cp ../../zsh/zshenv $HOME/.zshenv
rm -f $HOME/.zprofile
cp ../../zsh/zprofile $HOME/.zprofile
rm -f $HOME/.zshrc
cp ../../zsh/zshrc $HOME/.zshrc
mkdir -p $HOME/.zsh


# vim の設定
# vim がなければインストール
if [ ! `which vim` ]; then
	brew install zsh	
	sudo echo "/usr/local/bin/zsh" >> /etc/shells
	chsh -s /usr/local/bin/zsh
fi

rm -f $HOME/.vimrc
cp ../../vim/vimrc $HOME/.vimrc

dein_dir=$HOME/.vim/dein/
mkdir -p $dein_dir

rm -f $HOME/.vim/.dein.toml
cp ../../vim/dein.toml $HOME/.vim/.dein.toml
rm -f $HOME/.vim/.dein_lazy.toml
cp ../../vim/dein_lazy.toml $HOME/.vim/.dein_lazy.toml
