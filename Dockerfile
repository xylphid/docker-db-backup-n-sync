FROM registry.xylphid.net/backup:1.3

ARG VERSION
ENV VERSION ${VERSION:-"nightly"}

LABEL maintainer.name="Anthony PERIQUET"
LABEL maintainer.email="anthony@periquet.net"
LABEL version=${VERSION}
LABEL description="Database backup synchronization"

RUN apk add rsync

COPY scripts/* /opt/scripts/

VOLUME /opt/backups-dist/

ENTRYPOINT [ "/opt/scripts/configure.sh" ]