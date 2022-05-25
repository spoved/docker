FROM haveagitgat/tdarr_node:latest

RUN apt update && apt install -y \
  libfuse-dev \
  && apt-get clean && \
  rm -rf \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/*
RUN curl https://rclone.org/install.sh | bash
