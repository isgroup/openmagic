#!/bin/bash
# OpenMAGIC v0.2
#
# OpenSSL TLS heartbeat read overrun (CVE-2014-0160)
# Written by Francesco `ascii` Ongaro - 20140218
# (C) ISGroup SRL - http://www.isgroup.biz
# 

#  10-04-2014  Frodo Larik 
#    * Check all MX records of a domain 
#    * Sort by MX priority
#    * require domainname as argument


function mx() {
  local DOMAIN=$1;
  dig +noall +answer -t MX $DOMAIN | sort -n -k 5,6 | awk '{print $5, $6}' | sed "s/\.$//g" ;
}

function mta(){
  mx $1 | while read PRIO HOST; do
    echo "$PRIO $HOST checking ..."
    for PORT in 465 585 993 995; do
      ./ssltest.sh $HOST $PORT;
    done;
  done;
}

if [ "X" == "X${1}" ]; then
  echo "Usage: $0 [domain]";
  exit 0;
fi

mta $1;
