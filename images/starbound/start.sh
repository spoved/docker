#!/bin/sh
set -x

download_and_install() {
  # set -e
  cd /tmp

  apt-get update
  apt-get install -y wget 7zip

  echo "Downloading starbound..."
  wget "${STARBOUND_INSTALLER}" -O starbound.tgz
  if [ ! -e starbound.tgz ]; then
    echo "Unable to download installer"
    exit 1
  fi
  echo "Extracting..."
  7z x starbound.tgz
  if [ ! -e ./data/noarch ]; then
    echo "Unable to extract installer"
    exit 1
  fi
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

if [ ! -z "${STARBOUND_CONFIG}" ]; then
  if [ -e ${STARBOUND_CONFIG} ]; then
    # /starbound/game/storage/starbound_server.config
    # cp ${STARBOUND_CONFIG} ../storage/starbound_server.config

    echo "Linking starbound config"
    my_link=../storage/starbound_server.config

    if [ -L ${my_link} ]; then
      if [ -e ${my_link} ]; then
        echo "Good link"
      else
        echo "Broken link"
        rm ${my_link}
        ln -s ${STARBOUND_CONFIG} ${my_link}
      fi
    elif [ -e ${my_link} ]; then
      echo "Not a link"
      rm ${my_link}
      ln -s ${STARBOUND_CONFIG} ${my_link}
    else
      echo "Missing"
      ln -s ${STARBOUND_CONFIG} ${my_link}
    fi
  fi
fi

./starbound_server
