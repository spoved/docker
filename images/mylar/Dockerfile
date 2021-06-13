FROM ubuntu:bionic

# Set up static options
ENV DEBIAN_FRONTEND="noninteractive" \
  LANG="en_US.UTF-8" \
  LC_ALL="C.UTF-8" \
  LANGUAGE="en_US.UTF-8"

RUN apt-get -q update && \
  apt-get install -qy git curl python-pip python-dev build-essential python-pil \
  # pillow required libs
  libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev \
  tcl8.6-dev tk8.6-dev python-tk \
  # misc tools
  wget

# Install unrar
ENV RAR_VER "5.7.1"
RUN wget "http://www.rarlab.com/rar/unrarsrc-5.2.6.tar.gz" -O /root/unrarsrc-5.2.6.tar.gz && \
  tar xzf /root/unrarsrc-5.2.6.tar.gz -C /root/

WORKDIR /root/unrar
RUN make && make install && make lib && make install-lib
WORKDIR /
RUN rm -r /root/unrar*
ENV UNRAR_LIB_PATH /usr/lib/libunrar.so

# Install PIP libs
RUN pip install -U pip setuptools certifi && \
  pip2 install pillow configparser beautifulsoup4 unrar natsort PyPDF2

# Cleanup
RUN apt-get purge -y --auto-remove curl gcc build-essential python-dev && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /tmp/*

# RUN sed -i 's+http://comicvine.gamespot.com+http://cv-cache.meco.svc.cluster.local+g' /opt/mylar/lib/comictaggerlib/comicvinetalker.py /opt/mylar/mylar/__init__.py /opt/mylar/mylar/webserve.py /opt/mylar/mylar/importer.py
# RUN sed -i 's+https://comicvine.gamespot.com+http://cv-cache.meco.svc.cluster.local+g' /opt/mylar/lib/comictaggerlib/comicvinetalker.py /opt/mylar/mylar/__init__.py /opt/mylar/mylar/webserve.py /opt/mylar/mylar/importer.py
RUN groupadd plex --gid 119 && \
  useradd plex -m --gid 119 --uid 113 && \
  passwd -d plex && \
  addgroup root plex

# Clone needed repos
RUN git clone https://github.com/evilhero/mylar.git /opt/mylar

# RUN sed -i 's/time.sleep(30)/time.sleep(0)/g' /opt/mylar/mylar/search.py && \
RUN sed -i 's/localbypass = False/localbypass = True/g' /opt/mylar/mylar/search.py && \
  chown -R plex:plex /opt/mylar
RUN sed -i 's/#logger.info(out)/logger.info(out)/g' /opt/mylar/mylar/cmtagmylar.py && \
  sed -i 's/#logger.info(err)/logger.info(err)/g' /opt/mylar/mylar/cmtagmylar.py && \
  sed -i 's/files = natsorted(files, key=keyfunc, signed=False)/files = natsorted(files, key=keyfunc)/g' /opt/mylar/lib/comictaggerlib/comicapi/comicarchive.py

# Declare volumes needed
VOLUME ["/config","/data","/opt/mylar/cache"]

# Final setup
# USER plex
EXPOSE 8090
ENTRYPOINT ["/usr/bin/python", "/opt/mylar/Mylar.py", "--verbose", "--nolaunch", "--datadir=/config/mylar/", "--config=/config/mylar/mylar.ini"]
