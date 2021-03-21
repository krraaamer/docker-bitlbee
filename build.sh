#!/bin/bash

apt update
apt install -y --no-install-recommends autoconf automake build-essential gettext gcc libtool make \
libglib2.0-dev libhttp-parser-dev libotr5-dev libpurple-dev libgnutls28-dev \
libjson-glib-dev libpng-dev libolm-dev libprotobuf-c-dev protobuf-c-compiler \
libgcrypt20-dev libmarkdown2-dev libpurple-dev libsqlite3-dev libwebp-dev libtool-bin

cd
curl -LO# https://get.bitlbee.org/src/bitlbee-$BITLBEE_VERSION.tar.gz

# bitlbee
tar zxvf bitlbee-$BITLBEE_VERSION.tar.gz
cd bitlbee-$BITLBEE_VERSION
./configure --jabber=1 --purple=1
make
make install
make install-dev

# libtool --finish
libtool --finish /usr/local/lib/bitlbee

# cleanup
apt remove -y --purge autoconf automake autotools-dev binutils binutils-common binutils-x86-64-linux-gnu build-essential \
bzip2 cpp cpp-8 dpkg-dev g++ g++-8 gcc gcc-8 gettext gettext-base libbinutils libgcc-8-dev libsqlite3-dev libstdc++-8-dev \
libtasn1-6-dev libtool libtool-bin m4 make nettle-dev patch xz-utils
apt clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /tmp/*
cd
rm -fr /root/build.sh
rm -fr $BITLBEE_VERSION*

# add user bitlbee
adduser --system --home /var/lib/bitlbee --disabled-password --disabled-login --shell /usr/sbin/nologin bitlbee
touch /var/run/bitlbee.pid && chown bitlbee:nogroup /var/run/bitlbee.pid
