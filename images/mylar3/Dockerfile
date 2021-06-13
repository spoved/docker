ARG BASE_VERSION=3.8.2-alpine3.11
FROM python:${BASE_VERSION}

RUN \
  echo "**** install system packages ****" && \
  apk add --no-cache \
  git \
  # cfscrape dependecies
  nodejs \
  # unrar-cffi & Pillow dependencies
  build-base=0.5-r1 \
  # unrar-cffi dependencies
  libffi-dev=3.2.1-r6 \
  # Pillow dependencies
  zlib-dev=1.2.11-r3 \
  jpeg-dev=8-r6 \
  unrar

# TODO image could be further slimmed by moving python wheel building into a
# build image and copying the results to the final image.

RUN apk add --no-cache curl bash fuse

# RUN curl https://rclone.org/install.sh | bash

RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
  unzip rclone-current-linux-amd64.zip && \
  cd rclone-*-linux-amd64 && \
  cp rclone /usr/bin/ && \
  chown root:root /usr/bin/rclone && \
  chmod 755 /usr/bin/rclone


# set version label
# ARG MYLAR_COMMIT=v0.3.6
# LABEL version ${BASE_VERSION}_${MYLAR_COMMIT}

# It might be better to check out release tags than python3-dev HEAD.
# For development work I reccomend mounting a full git repo from the
# docker host over /app/mylar.
RUN echo "**** install app ****" && \
  git config --global advice.detachedHead false && \
  git clone https://github.com/kalinon/mylar3.git /app/mylar && \
  cd /app/mylar && \
  git fetch --all --tags && \
  git checkout master

RUN echo "**** install requirements ****" && \
  pip3 install --no-cache-dir -U -r /app/mylar/requirements.txt && \
  rm -rf ~/.cache/pip/*

# RUN sed -i 's/localbypass = False/localbypass = True/g' /app/mylar/mylar/search.py

RUN addgroup -g 119 plex && \
  adduser -S -u 113 -G plex plex && \
  passwd -d plex && \
  addgroup root plex && \
  chown -R plex:plex /app/mylar

# Declare volumes needed
VOLUME ["/config","/comics","/downloads"]

# Final setup
# USER plex
EXPOSE 8090
CMD ["python3", "/app/mylar/Mylar.py", "--nolaunch", "--datadir", "/config"]
