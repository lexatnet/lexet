build:
	./scripts/build-docker.sh

install:
	./scripts/install.sh

uninstall:
	./scripts/uninstall.sh

run-bush:
	./run-bash.sh

run-in-background:
	./scripts/run-in-background.sh

connect-bash:
	./scripts/connect-bash.sh

connect-to-root-sshd:
	docker exec --interactive --tty ide-root-sshd bash
