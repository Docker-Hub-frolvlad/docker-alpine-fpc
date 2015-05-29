FROM alpine:3.2

ENV FPC_VERSION="2.6.4" \
    FPC_ARCH="x86_64-linux"

RUN apk update && \
    apk add binutils && \
    cd /tmp && \
    wget ftp://gd.tuwien.ac.at/languages/pascal/fpc/dist/${FPC_VERSION}/${FPC_ARCH}/fpc-${FPC_VERSION}.${FPC_ARCH}.tar && \
    tar xf fpc-${FPC_VERSION}.${FPC_ARCH}.tar && \
    cd fpc-${FPC_VERSION}.${FPC_ARCH} && \
    rm demo* doc* && \
    echo -e '/usr\nN\nN\nN\n' | sh ./install.sh && \
    cd .. && \
    rm -r /tmp/* && \
    rm /var/cache/apk/*
