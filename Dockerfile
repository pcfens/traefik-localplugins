FROM docker.io/alpine AS downloader

WORKDIR /plugins-local/src/github.com

RUN apk add --no-cache git

RUN mkdir traefik \
    && cd traefik \
    && git clone -b v0.1.2 --depth 1 --single-branch https://github.com/traefik/plugin-log4shell.git

RUN mkdir acouvreur \
    && cd acouvreur \
    && git clone -b v1.1.1 --depth 1 --single-branch https://github.com/acouvreur/traefik-ondemand-plugin.git

FROM traefik:2.5.5

COPY --from=downloader /plugins-local /plugins-local