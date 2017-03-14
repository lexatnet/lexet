FROM ubuntu:16.04

COPY . /tmp

RUN chmod -R 777 /tmp

RUN /tmp/init.sh

CMD /tmp/run-emacs.sh
