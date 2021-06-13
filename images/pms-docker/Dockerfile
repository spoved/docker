FROM plexinc/pms-docker:latest

RUN usermod -o -u 0 plex
COPY 40-plex-first-run /var/run/s6/etc/cont-init.d/40-plex-first-run
