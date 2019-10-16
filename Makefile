build:
	./scripts/build-lexet-docker.sh

build-appimage-builder:
	./scripts/build-appimage-builder-docker.sh

docker-tag:
	./scripts/docker-tag.sh

docker-push:
	./scripts/docker-push.sh

build-appimage:
	wget -O - https://raw.githubusercontent.com/AppImage/pkg2appimage/master/pkg2appimage | bash -s -- ./recipe.yml

build-appimage-into-docker:
	./scripts/build-appimage-into-docker.sh

clean:
	./scripts/clean.sh
