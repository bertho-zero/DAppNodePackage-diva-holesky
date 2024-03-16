##############
# Base image #
##############
FROM debian:bullseye-slim as binary

ARG TARGETARCH
ARG UPSTREAM_VERSION
ENV DOWNLOAD_URL https://github.com/prysmaticlabs/prysm/releases/download

RUN DEBIAN_FRONTEND=noninteractive \
  apt update && apt install --assume-yes --no-install-recommends wget ca-certificates && \
  wget -q $DOWNLOAD_URL/$UPSTREAM_VERSION/validator-$UPSTREAM_VERSION-linux-${TARGETARCH:-amd64} -O /usr/local/bin/validator && \
  chmod +x /usr/local/bin/validator

################
# Runner image #
################
FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y ca-certificates file curl jq unzip zip && \
  rm -rf /var/lib/apt/lists/*

COPY --from=binary /usr/local/bin/validator /usr/local/bin

COPY entrypoint.sh /usr/local/bin

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
