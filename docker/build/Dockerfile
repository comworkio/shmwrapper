FROM alpine:3.12.0 AS base

RUN set -ex && \
    apk add --no-cache gcc musl-dev make

FROM base AS shmwrapper_builder_x86

RUN mkdir -p /src

COPY utils.c utils.h shmwrapper.c Makefile /src/

WORKDIR /src

RUN make shmwrapper

FROM alpine:3.12.0 AS shmwrapper_x86

ENV PATH "/shmwrapper:${PATH}"

WORKDIR /

COPY --from=shmwrapper_builder_x86 /src/shmwrapper /
