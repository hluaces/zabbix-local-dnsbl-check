#!/bin/bash -e
# Lists every IP on the local machine and formats the output
# as the JSON that Zabbix LLD expect.
readonly IP_PATTERN="inet ([0-9]{1,3}\\.){3}[0-9]{1,3}"
readonly LOOPBACK_PATTERN="127.0.0.1"

# Returns all local ips for the machine.
function getIps() {
    ip addr list |grep -Po "$IP_PATTERN"|cut -d ' ' -f 2|sort|uniq|grep -Fv "$LOOPBACK_PATTERN"
}

JSON="{\"data\":["

for ip in $(getIps);
do
    JSON="$JSON{\"{#LOCALIP}\":\"$ip\"},"
done

JSON="$JSON]}"
echo $JSON|sed -e 's/,]/]/g'
