FROM debian:bullseye
RUN apt-get update
RUN apt-get install --yes make libcmocka0 libdevmapper1* liburcu6 libaio1 libjson-c5 libedit2
VOLUME /build
WORKDIR /build/tests
ENV LD_LIBRARY_PATH=.:../libmpathcmd
ENTRYPOINT ["make"]

