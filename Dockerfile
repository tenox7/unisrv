FROM golang as gobuilder
WORKDIR /src
RUN git clone https://github.com/tenox7/wfm.git
WORKDIR /src/wfm
RUN go mod download
ARG TARGETARCH
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -o /wfm-${TARGETARCH}

WORKDIR /src
RUN git clone https://github.com/tenox7/rcpd.git
WORKDIR /src/rcpd
RUN go mod download
ARG TARGETARCH
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -o /rcpd-${TARGETARCH}

#WORKDIR /src
#RUN git clone https://github.com/tenox7/tftpd.git
#WORKDIR /src/tftpd
#RUN go mod download
#ARG TARGETARCH
#RUN CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -o /tftpd-${TARGETARCH}

FROM tenox7/unrar as unrar

FROM alpine
RUN apk add --no-cache unfs3 rpcbind e2fsprogs-extra proftpd samba-server busybox-extras file lzip lighttpd
RUN passwd -d root
RUN rm -f /etc/securetty
RUN mkdir /run/proftpd
EXPOSE 23 69/udp 80-81 111/udp 111/tcp 2049/tcp 2049/udp 139/tcp 445/tcp 514/tcp 21/tcp 50000-50100
VOLUME /srv
ADD exports /etc/exports
ADD proftpd.conf /etc/proftpd/proftpd.conf
ADD lighttpd.conf /etc/lighttpd/lighttpd.conf
ADD smb.conf /etc/samba/smb.conf
ADD init /init
ARG TARGETARCH
COPY --from=gobuilder /wfm-${TARGETARCH} /usr/sbin/wfm
COPY --from=gobuilder /rcpd-${TARGETARCH} /usr/sbin/rcpd
#COPY --from=builder /tftpd-${TARGETARCH} /usr/sbin/tftpd
COPY --from=unrar /bin/unrar /usr/local/bin/unrar
WORKDIR /srv
ENTRYPOINT ["/init"]
