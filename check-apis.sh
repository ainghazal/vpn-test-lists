#!/bin/sh
./miniooni -y -f ./hourly/000-vpn-providers.json -o report-apis.jsonl --repeat-every 3600 oonirun
