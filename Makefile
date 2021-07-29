build-appimage-builder:
	./scripts/build-appimage-builder-docker.sh

docker-push:
	./scripts/docker-push.sh

build-appimage:
	./scripts/build-appimage.sh

builder-bash:
	./scripts/builder-bash.sh

build-appimage-with-log:
	./scripts/build-appimage.sh |& tee build.log
