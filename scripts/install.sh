#!/bin/bash

# Colors
PURPLE='\033[0;34m'
PINK='\033[0;35m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;36m'
NC='\033[0m'

ZSH_FILE="$HOME/.zshrc"
BASH_FILE="$HOME/.bashrc"
HOMEBREW_NAME="Homebrew"
HOMEBREW_DIR="$HOME/$HOMEBREW_NAME"
HOMEBREW_TAPS_DIR="$HOMEBREW_DIR/Library/Taps"
HOMEBREW_GOINFRE_LIB="$HOME/goinfre/$HOMEBREW_NAME/Library"
HOMEBREW_GOINFRE_TAPS="$HOMEBREW_GOINFRE_LIB/Taps"
BREW_LINK="https://github.com/Homebrew/brew.git"
REPLY=""

# accept -y as an argument to skip the prompt
if [ $# -eq 1 ] && [ $1 = "-y" ]; then
    REPLY="y"
else
    # check if HOMEBREW_GOINFRE exist
    if [ -d "$HOMEBREW_DIR" ]; then
        echo -e $PINK"It seems as if you already have a brew on your account! $NC"
        echo -n -e $YELLOW"Do you want to reinstall brew on your account \
(This will delete all the packages you had)? $NC["$GREEN"y$NC/"$RED"n$NC] "
    else
        echo -n -e $YELLOW"Do you want to install brew? $NC["$GREEN"y$NC/"$RED"n$NC] "
    fi
    # ask user if he wants to install homebrew and install it
    read REPLY
fi

if [[ $REPLY =~ ^[Yy]$ ]]
then
    # clean everything regarding homebrew
    chmod +x clean.sh
    ./clean.sh -y

    # create required Directories
    mkdir -p $HOMEBREW_DIR
    mkdir -p $HOMEBREW_GOINFRE_LIB
    mkdir -p $HOMEBREW_GOINFRE_TAPS

    # install homebrew
    echo -e $BLUE"Installing $HOMEBREW_NAME..."$NC && \
    git clone $BREW_LINK $HOMEBREW_DIR > /dev/null 2>&1 && \

    # linking brew with goinfre
    echo -e $BLUE"linking $HOMEBREW_NAME Library..."$NC && \
    ln -s $HOMEBREW_GOINFRE_TAPS $HOMEBREW_TAPS_DIR && \

    # Adding brew to .zshrc
    echo -e $BLUE"Adding $HOMEBREW_NAME to '$ZSH_FILE'..."$NC && \
    echo -e "export PATH=$HOMEBREW_DIR/bin:"'$PATH' >> $ZSH_FILE && \
    zsh -c "source $ZSH_FILE" > /dev/null 2>&1 && \

    # Adding brew to .bashrc
    echo -e $BLUE"Adding $HOMEBREW_NAME to '$BASH_FILE'..."$NC && \
    echo -e "export PATH=$HOMEBREW_DIR/bin:"'$PATH' >> $BASH_FILE && \
    source $BASH_FILE > /dev/null 2>&1 && \

    # print results
    echo -e $GREEN"$HOMEBREW_NAME INSTALLED"$NC || \
    echo -e $RED"$HOMEBREW_NAME already exist"$NC

fi  
