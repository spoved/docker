# FROM archlinux:20191205
# RUN pacman -Sy --needed --noconfirm sudo git fakeroot binutils && \
#   useradd builduser -m && \
#   passwd -d builduser && \
#   printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers
# RUN sudo -u builduser bash -c 'gpg --receive-keys 465022E743D71E39' && \
#   sudo -u builduser bash -c 'cd ~ && git clone https://aur.archlinux.org/aurman.git aurman && cd aurman && makepkg -s --noconfirm'
# RUN pacman -U --noconfirm /home/builduser/aurman/aurman-*-any.pkg.tar.xz
# RUN pacman -Suy --noconfirm --overwrite=usr/lib/libtensorflow.so.1,usr/lib/libtensorflow_cc.so.1,usr/lib/libtensorflow_framework.so.1,usr/lib/libutf8proc.so.2,usr/lib/libbloom.so.1,usr/lib/libastyle.so.3
# RUN groupadd plex --gid 119 && \
#   useradd plex -m --gid 119 --uid 113 && \
#   passwd -d plex && \
#   printf 'plex ALL=(ALL) ALL\n' | tee -a /etc/sudoers

FROM kalinon/radarr:0.2.0.1450

USER plex
RUN aurman -S --noconfirm --skip_news --skip_new_locations --noedit radarr

VOLUME /downloads
VOLUME /config
VOLUME /tv

EXPOSE 7878

USER root

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
