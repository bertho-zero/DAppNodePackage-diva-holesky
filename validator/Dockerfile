ARG UPSTREAM_VERSION

FROM statusim/nimbus-validator-client:${UPSTREAM_VERSION}

COPY entrypoint.sh /usr/local/bin

WORKDIR /home/user/

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
