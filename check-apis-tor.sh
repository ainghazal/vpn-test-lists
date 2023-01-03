#!/bin/sh
./miniooni -y --proxy socks5://127.0.0.1:9050 -f ./hourly/000-vpn-providers.json -o report-apis.jsonl --repeat-every 3600 oonirun
