FROM ubuntu:20.10 AS spack

## Basic install/update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y apt-utils && apt-get clean
RUN apt-get update && apt-get dist-upgrade -y && apt-get clean

## Development
RUN apt-get install -y git python3 ca-certificates procps curl unzip jq build-essential automake gfortran && apt-get clean

## Setup Spack environment
ENV SPACK_ROOT=/spack HOME=/
RUN echo ". ${SPACK_ROOT}/share/spack/setup-env.sh" >> /etc/bash.bashrc
RUN install -dv -o nobody ${SPACK_ROOT} ${HOME}/.spack

## Build Spack
USER nobody
RUN git clone --depth=1 https://github.com/spack/spack.git
RUN ( . ${SPACK_ROOT}/share/spack/setup-env.sh ; spack install python py-pip )

## Set app envrionment
USER root
ENV APP=/app
RUN install -dv -o nobody ${APP}

## Build app environment
USER nobody
COPY spack.yaml ${APP}
RUN ( . ${SPACK_ROOT}/share/spack/setup-env.sh ; \
    spack env create -d ${APP} ; spack env activate -d ${APP} ; \
    spack install )
USER root
RUN echo "spack env activate -p ${APP}" >> /etc/bash.bashrc

## Install app
USER nobody
WORKDIR ${APP}
COPY --chown=nobody:nogroup one.py two.py ./
