#!/bin/sh
export HOME=/home/probe
#BACKEND=https://ams-pg-test.ooni.org
cd $HOME/ooni
for desc in oonirun/*.json;
do 
	#./miniooni -y -f $desc --probe-services $BACKEND oonirun;
	./miniooni -y -f $desc oonirun;
        # better: hostname + date +%Y-%m-%d-%s`
        mv report.jsonl store/`hostname`-`date +%Y-%m-%d-%s`.jsonl
done
