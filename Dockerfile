FROM alpine:3.16

ENV FPC_VERSION="3.2.2" \
    FPC_ARCH="x86_64-linux"

RUN apk add --no-cache binutils && \
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
    rm -r "/lib64" "/tmp/"*
