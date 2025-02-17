# UniSrv - Universal Server

An **EXTREMELY INSECURE**, LAN only, anonymous, wide open, all in one, universal server.

**WARNING** DO NOT USE !!!

## Servers

- Unfs3
- Samba
- ProFTPD
- Tftpd
- Rcpd
- WFM for httpd+upload
- Telnet (omg)
- lighttpd (for kodi)

## Directory

All servers expose `/srv` directory. Mount it as a volume with `-v`.

## Running

Docker Hub: https://hub.docker.com/r/tenox7/unisrv

Pick a local directory and mount it under `/srv` using `-v`.

For use with passive ftp, supply host IP address as `HOST_ADDRESS` env var.
On Linux you can use `hostname -i`, on macOS you may want to replace `hostname -i` with `ipconfig getifaddr en0` or just hardcode it.

```sh
docker run \
	-v /myhost/dir:/srv \
	--rm -d --privileged \
	--name unisrv \
	-e HOST_ADDRESS=$(hostname -i) \
	-p 69:69/udp \
	-p 80-81:80-81 \
	-p 139:139 -p 445:445 \
	-p 514:514 \
	-p 21:21 -p 50000-50100:50000-50100 \
	-p 111:111/udp -p 111:111/tcp \
	-p 2049:2049/udp -p 2049:2049/tcp \
	tenox7/unisrv:latest
```



## Troubleshooting

### On macOS unable to bind to 0.0.0.0/111

use your host static IP address:

```sh
docker run ... -p 192.168.0.5:111:111/udp -p 192.168.0.5:111:111/tcp
```

### On macOS unable to connect to tftpd

This is because it needs `modprobe nf_nat_tftp` and `nf_conntrack_tftp`.
Maybe set network mode to host or bridge?

### NFS mount fails with rpc.statd or lockd

Use nolock NFS mount option:

```sh
mount -o nolock
```

## References

- https://github.com/voobscout/unfs3
- https://github.com/nimbix/docker-unfs3
- https://wiki.openvz.org/index.php?title=NFS_server_inside_container&mobileaction
