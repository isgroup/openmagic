openmagic
=========

OpenSSL TLS heartbeat read overrun (CVE-2014-0160)

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
