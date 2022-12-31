#!/bin/sh
export HOME=/home/probe
#BACKEND=https://ams-pg-test.ooni.org
cd $HOME/ooni
for desc in oonirun/*.json;
do 
	#./miniooni -y -f $desc --probe-services $BACKEND oonirun;
	./miniooni -y -f $desc oonirun;
	./archive.sh report.jsonl store
done
