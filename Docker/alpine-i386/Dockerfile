FROM i386/alpine:latest
RUN apk add make perl gcc cmocka \
    musl-dev lvm2-dev libaio-dev readline-dev ncurses-dev eudev-dev \
    userspace-rcu-dev json-c-dev cmocka-dev
VOLUME /build
WORKDIR /build
ENTRYPOINT ["make"]
