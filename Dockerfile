FROM schachr/raspbian-stretch:latest
LABEL maintainer="Marco Grätsch <magdev3.0@gmail.com>"

ENV DOCKER_HOST=unix:///tmp/docker.sock \
    DOCKER_GEN_VERSION=0.7.4 \
    DOCKER_GEN_ARCH=armhf

RUN apt-get -qq update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        supervisor \
        tor \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* || true

WORKDIR /app
COPY ./bin/ /app/bin/
COPY ./files/docker-gen/torrc.tmpl /app/torrc.tmpl
COPY ./files/supervisor/supervisord.conf /etc/supervisor/supervisord.conf

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-$DOCKER_GEN_ARCH-$DOCKER_GEN_VERSION.tar.gz \
    && tar -C /usr/local/bin -xvzf docker-gen-linux-$DOCKER_GEN_ARCH-$DOCKER_GEN_VERSION.tar.gz \
    && rm docker-gen-linux-$DOCKER_GEN_ARCH-$DOCKER_GEN_VERSION.tar.gz \
    && chmod +x /app/bin/*.sh

VOLUME ["/var/lib/tor/hidden_services"]
EXPOSE 9001
ENTRYPOINT ["/app/bin/run.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
