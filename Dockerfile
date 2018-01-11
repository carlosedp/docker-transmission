FROM python:slim

MAINTAINER Carlos Eduardo <carlosedp@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y -q transmission-daemon && \
    rm -rf /var/lib/apt/lists/*

ADD settings.json /etc/transmission-daemon/settings.json

VOLUME /var/lib/transmission-daemon/downloads
VOLUME /etc/transmission-daemon

EXPOSE 9091
EXPOSE 51413
EXPOSE 51413/udp

CMD ["/usr/bin/transmission-daemon", "-f", "-g", "/etc/transmission-daemon"]

