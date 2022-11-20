#!/usr/bin/env python3
"""
Analyze a miniooni openvpn report and output basic summaries.
"""
import datetime
import json
import sys
import os
from urllib.parse import urlparse, parse_qs

TIME_FMT = '%Y-%m-%d %H:%M:%S'

MIN_VERSION = "0.0.16"

MIN_TS = None
MAX_TS = None

INPUTS = 0
PROVIDERS = []
PROTO = []
IPs = []
ADDRS = []

UDP = 0
TCP = 0
OBFS4 = 0

UDP_OK = 0
TCP_OK = 0
OBFS4_OK= 0

def versionParse(ver):
    v = ver.split('.')
    return int(v[0]) * 10000 + int(v[1]) * 1000  + int(v[2])

def isValidVersion(ver):
    return versionParse(ver) >= versionParse(MIN_VERSION)


def parseReport(path):
    measurements = []
    with open(path, 'rb') as f:
        measurements = [json.loads(line) for line in f.read().splitlines()]
        check_measurements(measurements)

def check_measurements(mm):
    global TCP, UDP, OBFS4, TCP_OK, UDP_OK, OBFS4_OK, INPUTS, MIN_TS, MAX_TS
    for m in mm:
        version = m['test_version']
        if not isValidVersion(version):
            continue

        start = m['measurement_start_time']
        ts = datetime.datetime.strptime(start, TIME_FMT)
        if MIN_TS == None:
            MIN_TS = ts
        if MAX_TS == None:
           MAX_TS = ts
        if ts > MAX_TS:
            MAX_TS = ts
        if ts < MIN_TS:
            MIN_TS = ts

        tk = m["test_keys"]
        icmp_ok = tk["success_handshake"]

        i = m["input"]
        INPUTS += 1
        url = urlparse(i)
        hostname = url.hostname
        proto, provider = hostname.split('.')
        PROTO.append(proto)
        PROVIDERS.append(provider)
        query = url.query
        params = parse_qs(query)
        addr = params['addr']
        if len(addr) != 1:
            print("wrong addr:", i)
            sys.exit(1)
        addr = addr[0]
        ADDRS.append(addr)
        tr = params['transport']
        if len(tr) != 1:
            print("wrong transport:", i)
            sys.exit(1)
        tr = tr[0]
        if tr.lower() == "udp":
            UDP += 1
            if icmp_ok:
                UDP_OK += 1
        elif tr.lower() == "tcp":
            TCP += 1
            if icmp_ok:
                TCP_OK += 1
        obfs = params['obfs']
        if len(obfs) != 1:
            print("wrong obfs:", i)
            sys.exit(1)
        obfs = obfs[0]
        if obfs.lower() == "obfs4":
            OBFS4 += 1
            if icmp_ok:
                OBFS4_OK += 1

    print("START:\t", datetime.datetime.strftime(MIN_TS, TIME_FMT))
    print("END:\t", datetime.datetime.strftime(MAX_TS, TIME_FMT))
    print("INPUTS:\t", INPUTS)
    print("PROTO:\t", ','.join([x for x in set(PROTO)]))
    print("PRVDR:\t", ','.join([x for x in set(PROVIDERS)]))
    print(f"UDP:\t{UDP_OK}/{UDP}")
    print(f"TCP:\t{TCP_OK}/{TCP}")
    print(f"OBFS4:\t{OBFS4_OK}/{OBFS4}")
    print("ADDRS:")
    for addr in sorted(list(set(ADDRS))):
        print(f"\t{addr}")


if __name__ == "__main__":
    path = sys.argv[1]
    if len(sys.argv) == 2 and os.path.exists(path):
        parseReport(path)
