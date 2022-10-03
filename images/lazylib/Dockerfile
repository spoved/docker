FROM linuxserver/lazylibrarian:latest
# Set up static options
ENV DEBIAN_FRONTEND="noninteractive" \
  LANG="en_US.UTF-8" \
  LC_ALL="C.UTF-8" \
  LANGUAGE="en_US.UTF-8"
RUN apt-get update && apt-get install -y \
  ffmpeg \
  calibre \
  fuse \
  unzip \
  ca-certificates \
  && apt-get clean && \
  rm -rf \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/*

RUN curl https://rclone.org/install.sh | bash

RUN sed -ie '/from lib.six.moves import configparser/a import urllib3\nurllib3.disable_warnings()' /app/lazylibrarian/LazyLibrarian.py
