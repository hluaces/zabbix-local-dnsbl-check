#!/bin/bash

if [[ $# -ne 2 ]]; then
	echo "Usage: ./${0##*/} <hostname> <blacklist service>"
	exit 1
fi

# Retrieves A record for hostname ($1)
HOSTLOOKUP=`host -t a $1`

# IP address validity check
if [[ ! ${HOSTLOOKUP##*[[:space:]]} =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
	echo "Could not resolve a valid IP for $1"
	exit 1
fi

# Converts resolved IP into reverse IP
REVIP=`sed -r 's/([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)/\4.\3.\2.\1/' <<< ${HOSTLOOKUP##*[[:space:]]}`

# Performs the actual lookup against blacklists
if host -W 2 -t a $REVIP.$2 >/dev/null 2>&1; then
	((listed++))
	echo $listed
else
	echo "0"
fi

exit 0