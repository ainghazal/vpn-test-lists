#!/bin/sh
FILE=$1
DEST=$2
mkdir -p $DEST
TS=`./check_measurements.sh $1 | grep START | cut -f 2,3,4 -d ':' | sed -e 's/^[ \t]*//' | sed -e 's/[ ]/_/g'`
HOSTNAME=$(hostname)
FILENAME="$2/${HOSTNAME}-${TS}.jsonl"
cp $1 $FILENAME
echo "archived" $1 as $FILENAME

