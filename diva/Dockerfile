ARG UPSTREAM_VERSION

FROM diva/diva:${UPSTREAM_VERSION}

RUN apk update && apk add logrotate

RUN mkdir -p /var/log/divad

COPY logrotate.conf /etc/logrotate.d/divad
COPY entrypoint.sh /usr/local/bin

WORKDIR /opt/diva/

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
