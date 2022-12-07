#!/bin/bash

download_and_install() {
  set -e
  cd /tmp
  echo "Downloading starbound..."
  wget ${STARBOUND_INSTALLER}
  echo "Extracting..."
  unzip starbound_1_4_4_34261.sh
  echo "Installing..."
  mv ./data/noarch/* /starbound
  echo "Cleaning up..."
  rm -r ./*
}

if [ ! -e /starbound/game ]; then
  echo "No game found, installing"
  download_and_install
fi

chown -R $USER /starbound

if [ -d /starbound/game/linux64 ]; then
  cd /starbound/game/linux64
else
  if [ -d /starbound/game/linux ]; then
    cd /starbound/game/linux
  else
    echo "I'm sorry, the game/linux folder doesn't exist or isn't in the right place."
  fi
fi

chmod +x starbound_server
./starbound_server
