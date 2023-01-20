#!/bin/sh
while :
do
        ./miniooni -f oonirun.exp/013-riseup-obfs4-proxy-speedtest.json -o report-speedtest.jsonl oonirun
        sleep 120
done
