#!/bin/bah
#
# Proof of concept in Bash.
# Get HTTP Server remote date using HTTP GZIP compression.
#
# usage: bash time.sh example.com

# This script is a quick and dirty PoC for getting the remote date of a server by reading
# the information contained in the gzip header of a compressed HTTP Response.
# This script is based on "time.php" of Jose Carlos Norte (jcarlos.norte@gmail.com).
# Author: Busindre (busilezas@gmail.com).

# In a single line.
# curl -sL0 --raw -k --compressed nickelfreesolutions.com | dd bs=4 skip=1 count=1 status=none > /tmp/caca; grep -qb V /tmp/caca && date -d @`od -t d4 /tmp/caca | awk '{print $2}'`

curl_raw=$(curl -sL0 --raw -k --compressed $1 | dd bs=4 skip=1 count=1 status=none)
if  grep -qb V <<< "$curl_raw" > /dev/null;then
	date -d @`echo $curl_raw | od -t d4 | awk '{print $2}'`
else
	echo "Error: Gzip headers, timestamp not found"
fi
