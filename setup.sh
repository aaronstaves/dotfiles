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


# Vim setup
echo "==> Setting up vim plugins"

# Pathogen #
echo "====> Setting up pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle && \

if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
	echo "linking pathogen.vim"
	ln -s `pwd`/vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim
else
	echo "pathogen.vim already exists.skipping"
fi

if [ -f ~/.vimrc ]; then
	if grep -q 'execute pathogen#infect()' ~/.vimrc; then
		echo "pathogen already found in .vimrc, skipping"
	else
		echo "pathogen not found in .vimrc, adding"
		sed -i '1iexecute pathogen#infect()' ~/.vimrc
	fi
else
	echo "could not find ~/.vimrc file"
fi

# Fugitive #
echo "====> Setting up fugitive"

if [ ! -f ~/.vim/bundile/vim-fugitive ]; then
	echo "fugitive not found, adding"
	ln -s `pwd`/vim-fugitive ~/.vim/bundle/vim-fugitive
else
	echo "fugitive found, skipping"
fi
