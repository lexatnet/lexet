build:
	./scripts/build-docker.sh

docker-tag:
	./scripts/docker-tag.sh

docker-push:
	./scripts/docker-push.sh

install:
	./scripts/install.sh

pyhton-install:
	python3 ./scripts/install.py

init:
	./scripts/init-lexet.sh

uninstall:
	./scripts/uninstall.sh

run-bash:
	./scripts/run-bash.sh

run-in-background:
	./scripts/run-in-background.sh

connect-bash:
	./scripts/connect-bash.sh

connect-to-root-sshd:
	docker exec --interactive --tty lexet-root-sshd bash
