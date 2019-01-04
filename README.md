Zabbix DNSBL check for mail servers
====

A Zabbix template which uses _UserParameters_ to check the status of every local IP address on a Linux machine.

It features a Low Level Discovery rule for the IP address of the server which generates a set of items and triggers that check the following DNSBL services:

* cbl.abuseat.org
* ips.backscatterer.org
* b.barracudacentral.org
* dnsbl.sorbs.net
* bl.spamcop.net
* zen.spamhaus

Configuration on the Zabbix server
====

* Create a value mapping (_Administration → General → Value mapping_) with the following information:
    * Name: _Blacklist listing status_
    * Mappings:
        * 0 : Not listed
        * 1: Listed
* Install the `.xml` template using the GUI (_Configuration → Templates → Import_).
* Add the templates to the hosts you want monitored.

Configuration on the monitored hosts
====

* Create the directory `/etc/zabbix/bin`.
* Copy both `rbl_listips.sh` and `rbl_check.sh` files to your `/etc/zabbix/bin` directory.
* Copy the file `userparameter_blacklist.conf` to your Zabbix agent configuration directory (normally `/etc/zabbix/zabbix_agentd.d/`).
* Restart your zabbix-agent service.

Disclaimer
====

Some DNSBL services might require registration or payment to use their services.

Take that into consideration if you plan on using this service on a high number of servers.

Credits
====

This template is loosely based on Martin Mørch's ["_Automatically check DNS Blackhole Lists (DNSBL)_"](https://share.zabbix.com/automatically-check-dns-blackhole-lists-dnsbl).

I created a new templates because Martin's uses external scripts to check the hostname of a remote system on the different DNSBL services and I needed to check every IP on a mail server with multiple network interfaces.

Author
====

Héctor Luaces Novo <hector |at| luaces-novo |dot| es>
