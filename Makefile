build-appimage-builder:
	./scripts/build-appimage-builder-docker.sh

docker-push:
	./scripts/docker-push.sh

build-appimage:
	./scripts/build-appimage.sh

clean:
	./scripts/clean.sh
