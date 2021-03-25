FROM multiarch/qemu-user-static:aarch64 as qemu
FROM arm64v8/debian:buster
COPY --from=qemu /usr/bin/qemu-aarch64-static /usr/bin
RUN apt-get update
RUN apt-get install --yes make libcmocka0 libdevmapper1* liburcu6 libaio1 libjson-c3
VOLUME /build
WORKDIR /build/tests
ENV LD_LIBRARY_PATH=.:../libmpathcmd
ENTRYPOINT ["make"]

