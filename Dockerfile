#### Build stage
FROM ubuntu:20.10 AS base

## Basic install/update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y apt-utils && apt-get clean
RUN apt-get update && apt-get dist-upgrade -y && apt-get clean
RUN apt-get install -y python3 ca-certificates procps curl unzip jq && apt-get clean
RUN apt-get install -y build-essential automake gfortran && apt-get clean

## Base envrionment
ENV SPACK_ROOT=/spack HOME=/ APP=/app
RUN install -dv -o nobody ${SPACK_ROOT} ${HOME}/.spack ${APP}
RUN echo ". ${SPACK_ROOT}/share/spack/setup-env.sh" >> /etc/bash.bashrc
RUN echo "spack env activate -p ${APP}" >> /etc/bash.bashrc

#### Setup Spack environment
FROM base AS spack

## Build Spack
RUN apt-get install -y git && apt-get clean
USER nobody
RUN git clone --depth=1 https://github.com/spack/spack.git
RUN ( . ${SPACK_ROOT}/share/spack/setup-env.sh ; spack install python py-pip )

## Build app environment
USER nobody
COPY spack.yaml ${APP}
RUN ( . ${SPACK_ROOT}/share/spack/setup-env.sh ; \
    spack env create -d ${APP} ; spack env activate -d ${APP} ; \
    spack install )

#### App stage
FROM spack AS app
USER nobody
WORKDIR ${APP}
COPY --chown=nobody:nogroup one.py two.py ./

### Clean stage
FROM spack AS clean
RUN ( . ${SPACK_ROOT}/share/spack/setup-env.sh ; spack gc --yes )

#### Runtime stage
FROM base AS deploy
COPY --from=clean ${SPACK_ROOT} ${SPACK_ROOT}
COPY --from=clean ${HOME}/.spack ${HOME}/.spack
COPY --from=app ${APP} ${APP}

# Expose App
USER nobody
WORKDIR ${APP}
