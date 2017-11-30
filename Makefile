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

run-in-background-as-root:
	./run-in-background-as-root.sh

connect-bash:
	./connect-bash.sh

connect-to-root-sshd:
	docker exec --interactive --tty ide-root-sshd bash
