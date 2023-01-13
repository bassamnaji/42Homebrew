#!/bin/bash

install_brew() {

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
        clean_brew -y

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
}

clean_brew() {
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
}

if [ -z $1 ]; then
  >&2 echo -e $RED"No operation provided!!"$NC
  >&2 echo -e $BLUE"Available operations$NC: ['"$YELLOW"install"$NC"' '"$YELLOW"clean"$NC"']"
  exit 1
fi

if [ $1 = "install" ]; then
  if [ $# -eq 2 ] && [ $2 = "-y" ]; then
    install_brew -y
  elif [ $# -eq 2 ]; then
      >&2 echo -e $RED"Wrong option name [$NC-y$RED]!!"$NC
      exit 1
  else
    install_brew
  fi
elif [ $1 = "clean" ]; then
  if [ $# -eq 2 ] && [ $2 = "-y" ]; then
    clean_brew -y
  elif [ $# -eq 2 ]; then
      >&2 echo -e $RED"Wrong option name [$NC-y$RED]!!"$NC
      exit 1
  else
    clean_brew
  fi
else
  >&2 echo "wrong script name!!"
  >&2 echo "available scripts: ['setup' 'install' 'clean']"
  exit 1
fi
