#!/bin/bash

set -e

DOTFILES_DIR="$HOME/.dotfiles"

# print help screen
function helpFunction()
{
	echo "Options:"
	echo "	-h, --help	prints this screen"
	echo "	-i, --init	initial installation"
	echo "	-u, --update	update arch package list"
	echo "	-p, --pip	update pip packages list"
	echo "	-a, --all	update all lists"
	echo "	-s, --sym	create symlinks"
	exit 0
}

# create a list of installed packages
function updatePackagesList()
{
	paru -Qqe > $DOTFILES_DIR/archPackages.list
}

# create a list of isntalled packages from pip
function updatePipList()
{
	python -m pip freeze > $DOTFILES_DIR/pipPackages.list
}

# update all the lists
function updateAll()
{
	updatePackagesList
	updatePipList
}

# install packages from list
function installPackages()
{
	if isCommandExist paru
	then
		paru --noconfirm -S --needed - < $DOTFILES_DIR/archPackages.list
	else
		echo "paru is not installed"
		exit 1
	fi
}

# install paru AUR helper
function installParu()
{
	if ! isCommandExist paru
	then
		sudo pacman --noconfirm -S --needed base-devel
		git clone https://aur.archlinux.org/paru.git
		cd paru
		makepkg -si
		cd ..
		rm -rf paru/
	else
		echo "paru already installed"
	fi
}

# install pip packages
function installPipPackages()
{
	if isCommandExist pip
	then
		python -m pip install -r $DOTFILES_DIR/pipPackages.list
	else
		echo "pip is not installed"
		exit 1
	fi
}

# repalced symlinks for cp because of sddm problems with symlinks
function sddmCP()
{
	# sddm themes
	sudo \cp -rf $DOTFILES_DIR/themes /usr/share/sddm/

	# sddm wallpapers
	sudo \cp -f $HOME/.local/share/wallpapers/*.jpg /usr/share/sddm/themes/Fedora_Mod

	# sddm settings
	sudo mkdir -p /etc/sddm.conf.d/
	sudo \cp -f $DOTFILES_DIR/kde_settings.conf /etc/sddm.conf.d/kde_settings.conf
}

# full initial installation of packages, themes, and zsh
function initFunc()
{
	installParu
	installPackages
	installPipPackages
	sddmCP	

	if isCommandExist xdg-user-dirs-update
	then
		xdg-user-dirs-update
	fi
	
	# install zsh
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	installFromGithub
}

# install additional stuff
function installFromGithub()
{
	# install GEF
	bash -c "$(curl -fsSL http://gef.blah.cat/sh)"

	# install Vundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
}



# check if command exists
function isCommandExist()
{
	if command -v $1 $> /dev/null
	then
		# return true
		return 0
	fi
	# return false
	return 1
}

# if there are no arguments print help screen
if [[ $# = 0 ]]
then
	helpFunction
fi

case $1 in 
	-i|--init	)	initFunc ;;
	-u|--update	)	updatePackagesList ;;
	-p|--pip	)	updatePipList ;;
	-a|--all	)	updateAll ;;
	-s|--sym	)	symlinks ;;
	*		)	helpFunction ;;
esac

exit 0
