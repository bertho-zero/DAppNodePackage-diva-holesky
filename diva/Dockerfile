ARG UPSTREAM_VERSION

FROM diva/diva:${UPSTREAM_VERSION}

RUN apk add --no-cache curl jq logrotate

RUN mkdir -p /var/log/divad
RUN mkdir -p /etc/diva/migrations

COPY logrotate.conf /etc/logrotate.d/divad
COPY entrypoint.sh /usr/local/bin

COPY migrations/ /etc/diva/migrations/

WORKDIR /var/diva/

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
