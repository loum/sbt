ARG ALPINE_DOCKER_VERSION

FROM alpine:${ALPINE_DOCKER_VERSION}

WORKDIR /tmp

ARG OPENJDK_LONG_VERSION
RUN set -eux; apk add --no-cache\
 openjdk8=${OPENJDK_LONG_VERSION}\
 bash\
 ncurses

ARG SBT_VERSION
RUN wget -qO- https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz |\
 tar zxf - -C /opt &&\
 ln -s /opt/sbt/bin/sbt /usr/local/bin

# Add our user and group first to make sure their IDs get assigned consistently,
# regardless of whatever dependencies get added.
RUN addgroup -S -g 30998 sbt &&\
 adduser -S -G sbt -u 30998 sbt

USER sbt
WORKDIR /app

ENTRYPOINT ["sbt"]
