#!/bin/bash -e
# This script is used to check wether an IP address is listed
# on a DNSRBL service.
if [[ $# -ne 2 ]]; then
    echo "Usage: ./${0##*/} <ip> <blacklist service>"
    exit 1
fi

# Converts resolved IP into reverse IP
REVIP=`sed -r 's/([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)/\4.\3.\2.\1/' <<< $1`

# Performs the actual lookup against blacklists
if host -W 2 -t a $REVIP.$2 >/dev/null 2>&1; then
    echo "1"
else
    echo "0"
fi

exit 0
