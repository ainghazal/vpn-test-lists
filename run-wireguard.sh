#!/bin/sh
export HOME=/root
BACKEND=https://ams-pg-test.ooni.org
cd /root/ooni
for desc in privaterun/*.json;
do 
	./miniooni.vpn -y -f $desc -o report-wg.jsonl oonirun;
	#./miniooni.vpn -y -f $desc --probe-services $BACKEND oonirun;
done
