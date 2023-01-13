#!/bin/bash

if [ -z $1 ]; then
  >&2 echo -e $RED"No operation provided!!"$NC
  >&2 echo -e $BLUE"Available operations$NC: ['"$YELLOW"install"$NC"' '"$YELLOW"clean"$NC"']"
  exit 1
fi

if [ $1 = "install" ]; then
  chmod +x install.sh
  if [ $# -eq 2 ] && [ $2 = "-y" ]; then
    ./install.sh -y
  elif [ $# -eq 2 ]; then
      >&2 echo -e $RED"Wrong option name [$NC-y$RED]!!"$NC
      exit 1
  else
    ./install.sh
  fi
elif [ $1 = "clean" ]; then
  chmod +x clean.sh
  if [ $# -eq 2 ] && [ $2 = "-y" ]; then
    ./clean.sh -y
  elif [ $# -eq 2 ]; then
      >&2 echo -e $RED"Wrong option name [$NC-y$RED]!!"$NC
      exit 1
  else
    ./clean.sh
  fi
else
  >&2 echo "wrong script name!!"
  >&2 echo "available scripts: ['setup' 'install' 'clean']"
  exit 1
fi
