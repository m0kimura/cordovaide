#!/bin/bash
cmd=$1
project=${PWD##*/}


##  FX UTILITY
  if [[ ${cmd} = "push" ]]; then
    dex push
    exit
  elif [[ ${cmd} = "stop" ]]; then
    docker stop fx-${project}
    exit
  elif [[ ${cmd} = "login" ]]; then
    docker exec -it fx-${project} /bin/bash
    exit
  elif [[ ${cmd} = "export" ]]; then
    echo Export Container fx-${project} to local/fx-${project}.tar
    docker export fx-${project} -o ../local/fx-${project}.tar
    exit
  elif [[ ${cmd} = "save" ]]; then
    echo Save Image ${project} to local/${project}.tar
    docker save ${project} -o ../local/${project}.tar
    exit
  fi
##
##
  xhost +local:user
  docker rm -f fx-${project}
  docker run -it --name fx-${project} \
    -e DISPLAY=$DISPLAY \
    -e XMODIFIERS=$XMODIFIERS \
    -e XIM=fcitx \
    -e GTK_IM_MODULE=$GTK_IM_MODULE \
    -e QT_IM_MODULE=$QT_IM_MODULE \
    -e LC_TYPE=ja_JP.UTF-8 \
    -e LANG=ja_JP.UTF-8 \
    -e TERM=xterm \
    -e DIR=$DIR \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev/shm:/dev/shm \
    -v fx-${project}:/home/docker \
    -v $HOME/$DIR:/home/docker/project \
    m0kimura/${project}

