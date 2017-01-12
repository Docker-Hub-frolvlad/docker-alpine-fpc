FROM alpine:3.5

ENV FPC_VERSION="3.0.0" \
    FPC_ARCH="x86_64-linux"

RUN apk add --no-cache binutils && \
    cd /tmp && \
    wget "ftp://gd.tuwien.ac.at/languages/pascal/fpc/dist/${FPC_VERSION}/${FPC_ARCH}/fpc-${FPC_VERSION}.${FPC_ARCH}.tar" -O fpc.tar && \
    tar xf "fpc.tar" && \
    cd "fpc-${FPC_VERSION}.${FPC_ARCH}" && \
    rm demo* doc* && \
    echo -e '/usr\nN\nN\nN\n' | sh ./install.sh && \
    cd .. && \
    rm -r "/tmp/"*
