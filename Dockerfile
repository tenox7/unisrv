FROM caddy:2-builder AS builder
WORKDIR /src
RUN xcaddy build --with github.com/git001/caddyv2-upload --output /caddy
FROM alpine
RUN apk add --no-cache unfs3 rpcbind e2fsprogs-extra proftpd tftp-hpa samba-server busybox-extras
RUN passwd -d root
RUN rm -f /etc/securetty
RUN mkdir /run/proftpd
EXPOSE 23 69/udp 80 111/udp 111/tcp 2049/tcp 2049/udp 139/tcp 445/tcp 21/tcp 65530 65531 65532 65533 65534
VOLUME /srv
ADD exports /etc/exports
ADD proftpd.conf /etc/proftpd/proftpd.conf
ADD smb.conf /etc/samba/smb.conf
ADD init /init
COPY --from=builder /caddy /usr/sbin/caddy
ADD Caddyfile /Caddyfile
ADD index.tmpl /index.tmpl
ENTRYPOINT ["/init"]
