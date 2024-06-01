docker:
	docker buildx build --platform linux/amd64,linux/arm64 -t tenox7/unisrv:latest --push .
