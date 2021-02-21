FROM ubuntu:20.10 AS spack

## Basic install/update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y apt-utils && apt-get clean
RUN apt-get update && apt-get dist-upgrade -y && apt-get clean

## Development
RUN apt-get install -y git python3 ca-certificates build-essential procps curl unzip jq && apt-get clean

## Set the environment
ENV SPACK_ROOT=/spack HOME=/
RUN echo ". ${SPACK_ROOT}/share/spack/setup-env.sh" >> /etc/bash.bashrc
RUN install -dv -o nobody ${SPACK_ROOT} ${HOME}/.spack

## Build Spack
USER nobody
RUN git clone --depth=1 https://github.com/spack/spack.git
RUN ( . ${SPACK_ROOT}/share/spack/setup-env.sh ; spack install python py-pip )
