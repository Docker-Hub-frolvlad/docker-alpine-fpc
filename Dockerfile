FROM alpine:3.19

ENV FPC_VERSION="3.2.2"

RUN apk add --no-cache binutils && \
    FPC_ARCH="$(uname -m)-linux" && \
    cd /tmp && \
    wget "https://downloads.sourceforge.net/project/freepascal/Linux/${FPC_VERSION}/fpc-${FPC_VERSION}.${FPC_ARCH}.tar" -O fpc.tar && \
    tar xf "fpc.tar" && \
    cd "fpc-${FPC_VERSION}.${FPC_ARCH}" && \
    rm demo* doc* && \
    \
    # Workaround musl vs glibc entrypoint for `fpcmkcfg`
    mkdir /lib64 && \
    ln -s /lib/ld-musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    \
    echo -e '/usr\nN\nN\nN\n' | sh ./install.sh && \
    find "/usr/lib/fpc/${FPC_VERSION}/units/${FPC_ARCH}/" -type d -mindepth 1 -maxdepth 1 \
        -not -name 'fcl-base' \
        -not -name 'rtl' \
        -not -name 'rtl-console' \
        -not -name 'rtl-objpas' \
        -exec rm -r {} \; && \
    rm -r "/lib64" "/tmp/"*
