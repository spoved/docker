FROM mdhiggins/sonarr-sma:latest
RUN curl https://rclone.org/install.sh | bash

RUN apt-get update && apt-get install -y fuse && \
  # cleanup
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

ENTRYPOINT ["/bin/bash"]
