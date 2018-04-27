build:
	./scripts/build-docker.sh

docker-tag:
	./scripts/docker-tag.sh

docker-push:
	./scripts/docker-push.sh

install:
	./scripts/install.sh

init:
	./scripts/init-ide.sh

uninstall:
	./scripts/uninstall.sh

run-bash:
	./scripts/run-bash.sh

run-in-background:
	./scripts/run-in-background.sh

connect-bash:
	./scripts/connect-bash.sh

connect-to-root-sshd:
	docker exec --interactive --tty ide-root-sshd bash
