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
    if [ $current_prereq == "ctags" ]; then
      echo "no, please install exuberant ctags!"
    else
      echo "no, please install $current_prereq"
    fi
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

#Should this install process be abstracted out? Yes! I am going to do that? Maybe.

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

#Install tagbar, of if it already exists, pull down the latest
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

#Install vim-fugitive, or if it already exists pull down the latest
echo -n "vim-fugitive..."
if [ -d ~/.vim/bundle/vim-fugitive ]; then
  cd ~/.vim/bundle/vim-fugitive && git status > /dev/null
  if [ $? -eq 0 ]; then
    echo -n "already installed, updating..."
    cd ~/.vim/bundle/vim-fugitive && git pull > /dev/null
    echo "done!"
  fi
else
  echo -n "installing..."
  cd ~/.vim/bundle && git clone https://github.com/tpope/vim-fugitive.git > /dev/null
  echo "done!"
fi

#Install syntastic
echo -n "Syntastic..."
if [ -d ~/.vim/bundle/syntastic ]; then
  cd ~/.vim/bundle/syntastic && git status > /dev/null
  if [ $? -eq 0 ]; then
    echo -n "already installed, updating..."
    cd ~/.vim/bundle/syntastic && git pull > /dev/null
    echo "done!"
  fi
else
  echo -n "installing..."
  cd ~/.vim/bundle && git clone https://github.com/scrooloose/syntastic > /dev/null
  echo "done!"
fi

#Install Git Gutter
echo -n "Git Gutter..."
if [ -d ~/.vim/bundle/vim-gitgutter ]; then
  cd ~/.vim/bundle/vim-gitgutter && git status > /dev/null
  if [ $? -eq 0 ]; then
    echo -n "already installed, updating..."
    cd ~/.vim/bundle/vim-gitgutter && git pull > /dev/null
    echo "done!"
  fi
else
  echo -n "installing..."
  cd ~/.vim/bundle && git clone https://github.com/airblade/vim-gitgutter.git > /dev/null
  echo "done!"
fi

#Install Trailer Trash
echo -n "Trailer Trash..."
if [ -d ~/.vim/bundle/trailertrash.vim ]; then
  cd ~/.vim/bundle/trailertrash.vim && git status > /dev/null
  if [ $? -eq 0 ]; then
    echo -n "already installed, updating..."
    cd ~/.vim/bundle/trailertrash.vim && git pull > /dev/null
    echo "done!"
  fi
else
  echo -n "installing..."
  cd ~/.vim/bundle && git clone https://github.com/csexton/trailertrash.vim.git > /dev/null
  echo "done!"
fi

#Install Vim Elixir
echo -n "Vim Elixir..."
if [ -d ~/.vim/bundle/vim-elixir ]; then
  cd ~/.vim/bundle/vim-elixir && git status > /dev/null
  if [ $? -eq 0 ]; then
    echo -n "already installed, updating..."
    cd ~/.vim/bundle/vim-elixir && git pull > /dev/null
    echo "done!"
  fi
else
  echo -n "installing..."
  cd ~/.vim/bundle && git clone https://github.com/elixir-lang/vim-elixir.git > /dev/null
  echo "done!"
fi


#Install .vimrc
################################################################################
cd $START_DIR && cp -f .vimrc ~/

echo "Done... enjoy!"
echo 
