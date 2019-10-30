build-appimage-builder:
	./scripts/build-appimage-builder-docker.sh

docker-push:
	./scripts/docker-push.sh

build-appimage:
	./scripts/build-appimage.sh

clean:
	./scripts/clean.sh

test-alpine:
	./scripts/test-alpine.sh

test-centos:
	./scripts/test-centos.sh

test-bionic:
	./scripts/test-ubuntu-bionic.sh
