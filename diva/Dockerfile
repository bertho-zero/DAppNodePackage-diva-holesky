ARG UPSTREAM_VERSION

FROM diva/diva:${UPSTREAM_VERSION}

RUN apk add --no-cache logrotate

RUN mkdir -p /var/log/divad

COPY logrotate.conf /etc/logrotate.d/divad
COPY entrypoint.sh /usr/local/bin

WORKDIR /var/diva/

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
