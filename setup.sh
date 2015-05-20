#!/usr/bin/env bash
OS="Unknown"
if [ `uname` == "Linux" ]; then
	OS="Linux"
elif [ `uname` == "Darwin"]; then
	OS="Darwin"
fi


_setup_tmux () {
	# Tmux
	echo "==> Setting up tmux"
	if hash tmux 2>/dev/null; then
		echo "tmux found, skipping"
	else
		echo "tmux not found, installing for $OS"
		if [ "$OS" == "Linux" ]; then
			sudo apt-get install tmux;
		else
			echo "Unsupported OS: $OS, skipping";
		fi
	fi
}

_setup_linux_packages () {
	echo "==> Setting up linux pacakges"

	LINUX_PACKAGES=( vim-nox python-pip python-setuptools python-dev python3 build-essential automake libtool )
	for pkg in "${LINUX_PACKAGES[@]}"
	do
		echo "====> $pkg"
		PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $pkg|grep "install ok installed")
		if [ "" == "$PKG_OK" ]; then
			echo "$pkg not found, installing";
			sudo apt-get -y install $pkg
		else
			echo "$pkg already installed, skipping"
		fi
	done

	PYTHON_PACKAGES=( psutil pyuv i3-py powerline-status )
	for pkg in "${PYTHON_PACKAGES[@]}"
	do
		echo "====> $pkg"
		PKG_OK=$(pip search $pkg|grep -i "installed")
		if [ "" == "$PKG_OK" ]; then
			echo "python package $pkg not found, installing";
			sudo pip install $pkg
		else
			echo "python package $pkg already installed, skipping"
		fi
	done

}

_setup_packages () {
	if [ "$OS" == "Linux" ]; then
		_setup_linux_packages
	else
		echo "cannot setup packages on OS: $OS, skipping"
	fi
}



########
# Start #
########

echo "==> Setting up on $OS system <==";

_setup_packages

_setup_tmux

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
git submodule update --init

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
	echo "pathogen.vim already exists, skipping"
fi

# Fugitive #
echo "====> Setting up fugitive"

if [ ! -d ~/.vim/bundle/vim-fugitive ]; then
	echo "fugitive not found, adding"
	ln -s `pwd`/vim-fugitive ~/.vim/bundle/vim-fugitive
else
	echo "fugitive found, skipping"
fi



