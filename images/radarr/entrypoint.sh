#!/usr/bin/env bash
set -xe
# chown -R plex:plex /downloads /tv /config
sudo -u plex bash -c "/usr/bin/mono --debug /usr/lib/radarr/Radarr.exe -nobrowser -data=/config"
