#!/bin/bash
# OpenMAGIC v0.3
#
# OpenSSL TLS heartbeat read overrun (CVE-2014-0160)
# Written by Francesco `ascii` Ongaro - 20140218
# (C) ISGroup SRL - http://www.isgroup.biz
#
# 11-04-2014 Francesco Ongaro
# - Refactoring and bump to 0.3

. ./common.sh

if [ $# -lt 1 ]; then
	echo "Usage: $0 hostname [top_ports]"
	echo "       $0 ip [top_ports]"
	exit 0
fi

TARGET=$1

MAX=20
if [ ! -z "$2" ]; then
	MAX=$2
fi

a $TARGET | while read HOST; do
	echo "# [ICSSL ] $PRIO $HOST ($TARGET)"
	sslports $MAX | while read $PORT; do
		echo "# [ICSSL ] $HOST $PORT ($TARGET)"
		./ssltest.sh $HOST $PORT
	done
done
