build:
	./build-docker.sh

install:
	./install.sh

uninstall:
	./uninstall.sh

run-bush:
	./run-bash.sh

run-in-background:
	./run-in-background.sh

connect-bash:
	./connect-bash.sh

connect-to-root-sshd:
	docker exec --interactive --tty ide-root-sshd bash
