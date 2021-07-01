ARG ALPINE_DOCKER_VERSION

FROM alpine:${ALPINE_DOCKER_VERSION} as builder

WORKDIR /tmp

ARG OPENJDK_LONG_VERSION
ARG SBT_LONG_VERSION
RUN set -eux; apk add --no-cache\
 openjdk8=${OPENJDK_LONG_VERSION}\
 bash\
 ncurses

# Add our user and group first to make sure their IDs get assigned consistently,
# regardless of whatever dependencies get added
RUN addgroup -S -g 30998 sbt &&\
 adduser -S -G sbt -u 30998 sbt

WORKDIR /home/sbt
USER sbt

RUN wget -qO- https://github.com/sbt/sbt/releases/download/v1.5.3/sbt-1.5.3.tgz | tar zxf -

ENTRYPOINT ["/home/sbt/sbt/bin/sbt"]
CMD ["-c"]
