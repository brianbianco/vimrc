#!/bin/bash


################################################################################
# Author: Brian Bianco
# Project Page: https://github.com/brianbianco/vimrc
#
# Description:
#
# This script will download and install my vim plugins along with installing
# my .vimrc into a users home directory.
#
# The tagbar plugin requires Exuberant ctags.  
#
# OSX: brew install ctags-exuberant
# Ubuntu: apt-get install exuberant-ctags 
#
# On OSX you may have to modify your path so that /usr/local/bin/ctags is used
# instead of /usr/bin/ctags
#
################################################################################

START_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#Colors as variables for convenience
black='\e[0;30m'        # Black
red='\e[0;31m'          # Red
green='\e[0;32m'        # Green
yellow='\e[0;33m'       # Yellow
blue='\e[0;34m'         # Blue
purple='\e[0;35m'       # Purple
cyan='\e[0;36m'         # Cyan
white='\e[0;37m'        # White

color_off='\e[0m'       # Text Reset

#Required setup checks
################################################################################
echo

#Make sure all prerequisite software is installed
echo "Checking that all required software is installed:"
prereqs=( vim curl git ctags )
for current_prereq in ${prereqs[@]}
do
  echo -n "$current_prereq..."
  type $current_prereq 2>&1 1>/dev/null
  if [ $? -ne 0 ]; then
    echo "no, please install $current_prereq"
    exit 1
  else
    if [ $current_prereq == "ctags" ]; then
      echo "yes, but please make sure it is exuberant ctags for tagbar to work properly!!"
    else
      echo "yes"
    fi
  fi
done

echo

#Make sure the .vim directory and its subdirectories autoload and bundle exist
echo "Checking that all required directories exist:"
dirs=( ~/.vim ~/.vim/autoload ~/.vim/bundle )
for current_dir in ${dirs[@]}
do
  echo -n "$current_dir..."
  if [ ! -d $current_dir ]; then
    echo "doesn't exist, creating it now"
    mkdir -p $current_dir
  else
    echo "exists!"
  fi
done

echo

#Plugin installation
################################################################################

echo "Installing plugins..."

#Install the latest version of pathogen
echo -n "pathogen..."
curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim > /dev/null
if [ $? -ne 0 ]; then
  echo "pathogen failed to install... aborting :("
  exit 1;
else
  echo "done!"
fi

#Install nerdtree, or if it already exists, pull down the latest
echo -n "nerdtree..."
if [ -d ~/.vim/bundle/nerdtree ]; then 
  cd ~/.vim/bundle/nerdtree && git status > /dev/null
  if [ $? -eq 0 ]; then
    echo -n "already installed, updating..."
    cd ~/.vim/bundle/nerdtree && git pull > /dev/null
    echo "done!"
  fi
else
  echo -n "installing..."
  cd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdtree.git > /dev/null
  echo "done!"
fi

#Install vim-surround, or if it already exists, pull down the latest
echo -n "vim-surround..."
if [ -d ~/.vim/bundle/vim-surround ]; then 
  cd ~/.vim/bundle/vim-surround && git status > /dev/null
  if [ $? -eq 0 ]; then
    echo -n "already installed, updating..."
    cd ~/.vim/bundle/vim-surround && git pull > /dev/null
    echo "done!"
  fi
else
  echo -n "installing..."
  cd ~/.vim/bundle && git clone https://github.com/tpope/vim-surround.git > /dev/null
  echo "done!"
fi

#https://github.com/majutsushi/tagbar.git
echo -n "tagbar..."
if [ -d ~/.vim/bundle/tagbar ]; then 
  cd ~/.vim/bundle/tagbar && git status > /dev/null
  if [ $? -eq 0 ]; then
    echo -n "already installed, updating..."
    cd ~/.vim/bundle/tagbar && git pull > /dev/null
    echo "done!"
  fi
else
  echo -n "installing..."
  cd ~/.vim/bundle && git clone https://github.com/majutsushi/tagbar.git > /dev/null
  echo "done!"
fi

#Install .vimrc
################################################################################
cd $START_DIR && cp -f .vimrc ~/

echo "Done... enjoy!"
echo 
