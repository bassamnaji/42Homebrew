#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;36m'
NC='\033[0m'

ZSH_FILE="$HOME/.zshrc"
BASH_FILE="$HOME/.bashrc"
HOMEBREW_NAME="Homebrew"
HOMEBREW_DIR="$HOME/$HOMEBREW_NAME"
HOMEBREW_GOINFRE="$HOME/goinfre/$HOMEBREW_NAME"
EXIST=0
if [ -d "$HOMEBREW_DIR" ]; then
    EXIST=1
fi

# accept -y as an argument to skip the prompt
if [ $# -eq 1 ] && [ $1 = "-y" ]; then
    reply="y"
else
    # ask user if he wants to install homebrew and install it
    echo -n -e $YELLOW"ARE YOU SURE YOU WANT TO REMOVE BREW FROM YOUR ACCOUNT? $NC["$GREEN"y$NC/"$RED"n$NC] "
    read reply
fi

if [[ $reply =~ ^[Yy]$ ]]
then

    # check if HOMEBREW_GOINFRE exist and remove it
    if [ -d "$HOMEBREW_DIR" ]; then
        echo -e $BLUE"Removing $HOMEBREW_DIR..."$NC
        rm -rf $HOMEBREW_DIR
    fi

    # check if HOMEBREW_GOINFRE exist and remove it
    if [ -d "$HOMEBREW_GOINFRE" ]; then
        echo -e $BLUE"Removing $HOMEBREW_GOINFRE..."$NC
        rm -rf $HOMEBREW_GOINFRE
    fi

    if grep -q "PATH=$HOMEBREW_DIR/bin:"'$PATH' $ZSH_FILE; then
        echo -e $BLUE"Removing $HOMEBREW_NAME from $ZSH_FILE..."$NC
        sed -i '' "/$HOMEBREW_NAME/d" $ZSH_FILE
    fi

    # check if "PATH=HOMEBREW_DIR/bin:$PATH" exist in .zshrc and remove the whole line
    if grep -q "PATH=$HOMEBREW_DIR/bin:"'$PATH' $BASH_FILE; then
        echo -e $BLUE"Removing $HOMEBREW_NAME from $BASH_FILE..."$NC
        sed -i '' "/$HOMEBREW_NAME/d" $BASH_FILE
    fi
    if [ $EXIST -eq 1 ]; then
        echo -e $GREEN"$HOMEBREW_NAME is removed successfully"$NC
    else
        echo -e $GREEN"$HOMEBREW_NAME is already removed"$NC
    fi
else
    exit 1
fi
