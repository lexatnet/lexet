build-appimage-builder:
	./scripts/build-appimage-builder-docker.sh

docker-push:
	./scripts/docker-push.sh

build-appimage:
	./scripts/build-appimage.sh

appimage-builder-bash:
	./scripts/appimage-builder-bash.sh

build-appimage-test:
	./scripts/build-appimage-test.sh

clean:
	./scripts/clean.sh

test-alpine:
	./scripts/test-alpine.sh

test-centos:
	./scripts/test-centos.sh

test-ubuntu-bionic:
	./scripts/test-ubuntu-bionic.sh
