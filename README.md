# UniSrv - Universal Server

An **EXTREMELY INSECURE**, LAN only, anonymous, wide open server.

**WARNING** DO NOT USE !!!

## Servers

- UNFS3
- PROFTPD
- TFTPD
- SAMBA
- CADDY HTTP + UPLOAD

## Directory

All servers expose `/srv` directory. Mount it as a volume with `-v`.

## Running

Pick a local directory and mount it under `/srv` using `-v`:

```sh
docker run \
	--rm -d --privileged \
	--name unisrv \
	-v /myhost/dir:/srv \
	-p 69:69/udp \
	-p 80:80 \
	-p 139:139 -p 445:445 \
	-p 21:21 -p 65530-65534:65530-65534 \
	-p 111:111/udp -p 111:111/tcp \
	-p 2049:2049/udp -p 2049:2049/tcp \
	tenox7/unisrv:latest
```

## Issues

### On macOS unable to bind to 0.0.0.0/111

use your host static IP address:

```sh
docker run ... -p 192.168.0.5:111:111/udp -p 192.168.0.5:111:111/tcp
```

### On macOS unable to connect to tftpd

This is because it needs `modprobe nf_nat_tftp` and `nf_conntrack_tftp`.
Maybe set network mode to host? `--network=host`

### NFS mount fails with rpc.statd or lockd

mount -o nolock

## References

- https://github.com/voobscout/unfs3
- https://github.com/nimbix/docker-unfs3
- https://wiki.openvz.org/index.php?title=NFS_server_inside_container&mobileaction
