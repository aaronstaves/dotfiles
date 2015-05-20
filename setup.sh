#!/usr/bin/env bash
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
