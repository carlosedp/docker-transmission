ARG target=arm32v6
FROM $target/alpine

ARG arch=arm
ENV ARCH=$arch

# Trick docker build in case qemu binary is not in dir.
COPY .blank tmp/qemu-$ARCH-static* /usr/bin/

RUN apk update && \
    apk upgrade && \
    apk add transmission-daemon && \
    rm -rf /var/cache/apk/*

ADD settings.json /etc/transmission-daemon/settings.json

VOLUME /volumes/media
VOLUME /etc/transmission-daemon

EXPOSE 9091
EXPOSE 51413
EXPOSE 51413/udp

CMD ["/usr/bin/transmission-daemon", "-f", "-g", "/etc/transmission-daemon"]
