#!/bin/bash

if [ -z "$1" ]; then
  echo "URL required"
  exit 1
fi

GZIP_TIMESTAMP=`curl -sL0 --raw --compressed -k "$1" | od -An -t u4 -j 4 -N 4 | xargs`

if [ -z $GZIP_TIMESTAMP ]; then
  echo "Failed to get URL $1"
  exit 1
fi

if [ $GZIP_TIMESTAMP -eq "0" ]; then
  echo "Gzip timestamp missing"
  exit 1
fi

DATE=`date --date="@$GZIP_TIMESTAMP"`

echo "Gzip timestamp: $GZIP_TIMESTAMP"
echo "Date: $DATE"
