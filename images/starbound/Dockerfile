FROM centos:latest
RUN yum install -y wget vim unzip
RUN wget http://mirror.centos.org/centos/8/PowerTools/x86_64/os/Packages/SDL2-2.0.8-7.el8.x86_64.rpm && \
  yum install -y SDL2-2.0.8-7.el8.x86_64.rpm && rm SDL2-2.0.8-7.el8.x86_64.rpm

ADD starbound_1_4_4_34261.sh /tmp/
RUN mkdir -p /opt/starbound && \
  /bin/sh -c "unzip /tmp/starbound_1_4_4_34261.sh -d /tmp/ \"data/noarch/game/*\"; true" && \
  mv /tmp/data/noarch/game/* /opt/starbound && \
  rm /tmp/starbound_1_4_4_34261.sh

RUN chmod +x /opt/starbound/linux/starbound_server

# Expose necessary ports
EXPOSE 21025/tcp

WORKDIR /opt/starbound/linux
CMD ["./starbound_server"]
