
build-appimage-builder:
	./scripts/build-appimage-builder-docker.sh

build-gulp-appimage-builder:
	./scripts/build-gulp-appimage-builder-docker.sh

docker-push:
	./scripts/docker-push.sh

gulp-builder-build-appimage:
	./scripts/gulp-builder-build-appimage.sh

gulp-builder-bash:
	./scripts/gulp-builder-bash.sh

build-appimage-with-log:
	./scripts/build-appimage.sh |& tee build.log
