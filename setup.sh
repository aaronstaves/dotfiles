#!/usr/bin/env bash

# Dotfiles
echo "==> Linking Files"
if [ ! -d ~/.config ]; then
	ln -s `pwd`/.config ~/.config
else
	echo ".config exists, skipping"
fi

if [ ! -f ~/.tmux.conf ]; then
	ln -s `pwd`/.tmux.conf ~/.tmux.conf
else
	echo ".tmux.conf exists, skipping"
fi

if [ ! -f ~/.vimrc ]; then
	ln -s `pwd`/.vimrc ~/.vimrc
else
	echo ".vimrc exists, skipping"
fi

# Submodules
echo "==> Initializing submodules"
git submodule init
git submodule update

# Liquidprompt
LIQUIDPROMPT_FILE=`pwd`/liquidprompt/liquidprompt
echo "==> Adding liquidprompt"

if [ -f "$LIQUIDPROMPT_FILE" ]; then
	if grep -q "$LIQUIDPROMPT_FILE" ~/.bashrc; then
		echo "already addded to .bashrc, skipping"
	else
		echo "liquidprompt not found in ~/.bashrc, adding"
		echo "" >> ~/.bashrc
		echo "#adding liquid prompt from dotfiles" >> ~/.bashrc
		echo "source \"$LIQUIDPROMPT_FILE\"" >> ~/.bashrc
		echo "" >> ~/.bashrc
	fi
else
	echo "liquidprompt not found, skipping"
fi
