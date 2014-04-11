openmagic
=========

openmagic can assist you in the automating testing and exploiting of systems vulnerable to the *OpenSSL TLS heartbeat read overrun (CVE-2014-0160)*. The base module wraps a modified version of the "ssltest.py" program by Jared Stafford and provides the following additional features:

- Save the leaked data in a raw format for later analisys
- Resolve the IP so that only one DNS query is executed
- Use NMAP to check if the target service is alive (or filtered/closed)
- Check if the target is vulnerable
- Iterate and sleep between multiple requests

(C) ISGroup SRL http://www.isgroup.biz

Written by Francesco Ongaro (https://linkedin.com/in/ongaro)

Usage to test a specific port, like HTTPS:

```
$ ./ssltest.sh login.foo.com 443
# [Open  ] login.foo.com:443 (1.2.3.5)
# [Vuln  ] login.foo.com:443
# [Loop  ] login.foo.com:443 %1
...
# [Loop  ] login.foo.com:443 %1000
```

Usage to automatically test MTA systems:

```
$ ./sslmail.sh foobar.com
# [Closed] mx6.foobar.com:465
# [Closed] mx6.foobar.com:585
# [Open  ] mx6.foobar.com:993 (1.2.3.4)
# [Safe  ] mx6.foobar.com:993
# [Open  ] mx6.foobar.com:995 (1.2.3.4)
# [Safe  ] mx6.foobar.com:995
```

Test 30 most common SSL ports on a target:

```
$ ./sslports.sh www.foobar.com 30
# [ICSSL ] 1.2.3.6 (www.foobar.com)
# [Closed] 1.2.3.6:443 (1.2.3.6)
# [Closed] 1.2.3.6:21 (1.2.3.6)
# [Open  ] 1.2.3.6:22 (1.2.3.6)
# [Safe  ] 1.2.3.6:22 (1.2.3.6)
[..]
# [Closed] 1.2.3.6:2002 (1.2.3.6)
# [Closed] 1.2.3.6:5000 (1.2.3.6)
```

Kill all the running threads:

```
ps aux | grep ./ssltest.sh | awk '{print $2}' | xargs kill
```

Scan a large CSV file:

```
tail -n 1000 top-1m.csv | sort -r | cut -d "," -f2 | xargs -P 20 -I {} ./ssltest.sh {} 443
```

~DO NOT HARM~

Contribute to openmagic
--------

If you want to submit or propose a feature feel free to open an issue https://github.com/isgroup-srl/openmagic/issues.

Requirements
--------

You need in your $PATH the following dependencies: 

- bash
- python2.6
- nmap
- dig
- torify
- tor
