FROM ubuntu:16.04

ARG build_root=/build
ARG build_script=$build_root/init.sh
ARG entrypoint_script=ide

COPY ./docker $build_root/docker
COPY ./config/config.sh $build_root/config/config.sh
COPY ./scripts/lib $build_root/scripts/lib

RUN chmod -R 777 $build_root

RUN $build_script

EXPOSE 2222

ENV ENTRYPOINT_SCRIPT=${entrypoint_script}

ENTRYPOINT ["bash", "-c", "${ENTRYPOINT_SCRIPT}"]
