FROM multiarch/qemu-user-static:ppc64le as qemu
FROM ppc64le/debian:buster
COPY --from=qemu /usr/bin/qemu-ppc64le-static /usr/bin
RUN apt-get update
RUN apt-get install --yes make libcmocka0 libdevmapper1* liburcu6 libaio1 libjson-c3 libedit2
VOLUME /build
WORKDIR /build/tests
ENV LD_LIBRARY_PATH=.:../libmpathcmd
ENTRYPOINT ["make"]

