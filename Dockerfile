# vi: ft=Dockerfile

FROM fedora:21
MAINTAINER Kurt Neufeld <kneufeld@burgundywall.com>

RUN yum makecache
RUN yum -y install uwsgi uwsgi-plugin-php
RUN yum -y install php-pdo php-pgsql php-bcmath php-mysqlnd

RUN mkdir -p /opt
ADD webzash-v2.6.tar.gz /opt/
RUN chown -R uwsgi /opt/webzash

ENV LISTEN_SOCKET :8030
CMD uwsgi --uwsgi-socket $LISTEN_SOCKET --ini /opt/config/uwsgi.ini
