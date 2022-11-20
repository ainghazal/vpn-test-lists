#!/bin/sh
export HOME=/root
BACKEND=https://ams-pg-test.ooni.org
cd /root/ooni
for desc in oonirun/*.json;
do 
	./miniooni.vpn -y -f $desc --probe-services $BACKEND oonirun;
	./archive.sh report.jsonl store
done
