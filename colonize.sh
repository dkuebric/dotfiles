#!/bin/sh

CWD=`pwd`

# bash
ln -s $CWD/.bashrc ~/.bashrc
ln -s $CWD/.bash_aliases ~/.bash_aliases
ln -s $CWD/.bash_logout ~/.bash_logout
ln -s $CWD/.inputrc ~/.inputrc
touch ~/.bash_aliases_local

# vim
ln -s $CWD/.vimrc ~/.vimrc
ln -s $CWD/.vim ~/.vim

# git
ln -s $CWD/.gitconfig ~/.gitconfig

# osx
ln -s $CWD/.profile ~/.profile

# osx terminal
cp ~/Library/Preferences/com.apple.Terminal.plist ~/Library/Preferences/com.apple.Terminal.plist.bak
cp ./osx/com.apple.Terminal.plist ~/Library/Preferences/com.apple.Terminal.plist
defaults read com.apple.Terminal
