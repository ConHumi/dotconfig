#!/bin/sh

# nvim configuration
# nvim がなければ設定しない
if [ `which nvim` ]; then
	mkdir $HOME/.config
	mkdir -p $HOME/.config/nvim
	mkdir -p $HOME/.config/nvim/dein
	echo 'export XDG_CONFIG_HOME=$HOME/.config' >> $HOME/.bashrc
	
	cp ../../nvim/nvimrc $HOME/.config/nvim/init.vim
	cp ../../nvim/.dein.toml $HOME/.config/nvim/.dein.toml
	cp ../../nvim/.dein_lazy.toml $HOME/.config/nvim/.dein_lazy.toml
	cp ../../nvim/.bashrc $HOME/.bashrc
	dein_dir=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim
	git clone https://github.com/Shougo/dein.vim $dein_dir
fi

# vim の設定
# vim がなければ設定しない
if [ ! `which vim` ]; then
	rm -f $HOME/.vimrc
	cp ../../vim/vimrc $HOME/.vimrc
	
	dein_dir=$HOME/.vim/dein/
	mkdir -p $dein_dir
	
	rm -f $HOME/.vim/.dein.toml
	cp ../../vim/dein.toml $HOME/.vim/.dein.toml
	rm -f $HOME/.vim/.dein_lazy.toml
	cp ../../vim/dein_lazy.toml $HOME/.vim/.dein_lazy.toml
fi

# zsh の設定
# zsh がなければインストール
if [ ! `which zsh` ]; then
	sudo apt-get install zsh -y
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


# tmux の設定
if [ ! `which tmux` ]; then
	sudo apt-get install tmux -y
fi

rm -f $HOME/.tmux.conf
cp ../../tmux/tmux.conf $HOME/.tmux.conf
