FROM alpine
MAINTAINER as@tenoware.com
RUN apk add --no-cache unfs3 rpcbind e2fsprogs-extra proftpd tftp-hpa samba-server
RUN mkdir /run/proftpd
EXPOSE 69/udp 111/udp 111/tcp 2049/tcp 2049/udp 139/tcp 445/tcp 21/tcp 65530 65531 65532 65533 65534
VOLUME /srv
ADD exports /etc/exports
ADD proftpd.conf /etc/proftpd/proftpd.conf
ADD smb.conf /etc/samba/smb.conf
ADD init /init
ENTRYPOINT ["/init"]
