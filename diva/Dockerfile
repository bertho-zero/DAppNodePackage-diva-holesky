ARG UPSTREAM_VERSION

FROM diva/diva:${UPSTREAM_VERSION}

RUN apt-get update && apt-get install -y logrotate

RUN mkdir -p /var/log/divad

COPY logrotate.conf /etc/logrotate.d/divad
COPY entrypoint.sh /usr/local/bin

WORKDIR /var/diva/

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
