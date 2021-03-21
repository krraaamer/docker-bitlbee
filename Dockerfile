FROM buildpack-deps:stable-scm
LABEL maintainer="Cosmo Kramer <krraaamer@gmail.com>"
LABEL name="Kramer's Bitlbee Stack"
LABEL version="2021-03-21"

ENV BITLBEE_VERSION=3.6

COPY build.sh /root
RUN /root/build.sh

VOLUME ["/usr/local/etc/bitlbee"]
VOLUME ["/var/lib/bitlbee"]
EXPOSE 6667
ENTRYPOINT ["/usr/local/sbin/bitlbee"]
CMD ["-c", "/usr/local/etc/bitlbee/bitlbee.conf", "-n", "-v"]
USER bitlbee
