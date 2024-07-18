docker-local:
	docker buildx build --platform linux/arm64 -t tenox7/unisrv:latest --load .

docker-push:
	docker buildx build --platform linux/amd64,linux/arm64 -t tenox7/unisrv:latest --push .

clean:
	docker rmi -f tenox7/unisrv:latest
	docker builder prune -a -f
	docker buildx prune -a -f
