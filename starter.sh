#!/bin/bash
##
  cd project
  if [[ ! -e cordova ]]; then
    git clone https://github.com/m0kimura/cordova.git
  fi
  export PATH=$HOME/project/cordova/tools:$PATH
  if [[ $MODULE = "$null" ]]; then
    code $HOME/project/cordova
    /bin/bash
  else
    /bin/bash -c $MODULE
  fi
##
