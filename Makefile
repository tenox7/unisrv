docker:
	docker buildx build --platform linux/arm64 -t tenox7/unisrv:latest --load .
#linux/amd64,