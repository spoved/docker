FROM ubuntu:16.04

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

ENV php_timezone America/New_York
ARG DEBIAN_FRONTEND=noninteractive

# install the Pre Reqs and Apache
RUN apt-get update && apt-get -yq install php php-dev php-pear php-gd php-mysql php-curl \
  libmysqlclient-dev apache2 libapache2-mod-php subversion unrar-free \
  lame software-properties-common mediainfo supervisor \
  ffmpeg mysql-client git

# need to add your Newznab plus SVN Password and user here http://newznab4win.blogspot.com.au/2013/01/installing-newznab.html
ARG nn_user
ARG nn_pass
ENV php_timezone America/New_York
ENV path /:/var/www/html/www/

# add the Config to Apache
ADD files/apache2/newznab.conf /etc/apache2/sites-available/newznab.conf
RUN mkdir /var/www/newznab/

# pull NNab plus from SVN - Note you need the username and password for Svn Above
RUN svn co --username $nn_user --password $nn_pass svn://svn.newznab.com/nn/branches/nnplus /var/www/newznab/

RUN chmod 777 /var/www/newznab/www/lib/smarty/templates_c && \
  chmod 777 /var/www/newznab/www/covers/movies && \
  chmod 777 /var/www/newznab/www/covers/anime  && \
  chmod 777 /var/www/newznab/www/covers/music  && \
  chmod 777 /var/www/newznab/www  && \
  chmod 777 /var/www/newznab/www/install  && \
  chmod 777 /var/www/newznab/nzbfiles/

ENV php_mem=4096M

# Enable memcache
RUN pecl install memcache
ADD files/cli/php.ini /etc/php/7.0/cli/php.ini
ADD files/apache2/php.ini /etc/php/7.0/apache2/php.ini
ADD files/apache2/phpmemcacheadmin.conf /etc/apache2/sites-available/phpmemcacheadmin.conf
RUN a2ensite phpmemcacheadmin
RUN mkdir -p /var/www/phpmemcacheadmin/Config && chmod -R 777 /var/www/phpmemcacheadmin

ENV APACHE_RUN_DIR /var/run/apache2

# Disable Default site and enable newznab site - Restart Apache here to confirm your newznab.conf is valid in case you changed it
RUN a2dissite 000-default.conf
RUN a2ensite newznab
RUN a2enmod rewrite
RUN service apache2 restart

# add newznab config file - This needs to be edited
ADD files/config.php /var/www/newznab/www/config.php
RUN chmod 777 /var/www/newznab/www/config.php
RUN mkdir -p /var/www/newznab/www/covers/tv && chmod 777 /var/www/newznab/www/covers/tv

# Add newznab processing script
ADD files/newznab.sh /newznab.sh
RUN chmod 755 /*.sh

# Setup supervisor to start Apache and the Newznab scripts to load headers and build releases
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor
ADD files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN a2dismod php7.0 && a2enmod php7.0

ADD files/apache2/apache2.conf /etc/apache2/apache2.conf
ADD files/apache2/ports.conf /etc/apache2/ports.conf

# Setup NZB volume this will need to be mapped locally using -v command so that it can persist.
EXPOSE 80
EXPOSE 12323
VOLUME /nzb
WORKDIR /var/www/html/www/
#kickoff Supervisor to start the functions
CMD ["/usr/bin/supervisord"]
