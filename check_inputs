#!/usr/bin/env python3
import json
import sys
import os
from urllib.parse import urlparse, parse_qs

INPUTS = 0
PROVIDERS = []
PROTO = []
IPs = []
ADDRS = []
UDP = 0
TCP = 0
OBFS4 = 0


def check_inputs(j):
    global TCP, UDP, OBFS4, INPUTS
    nettests = j['nettests']
    for t in nettests:
        for i in t['inputs']:
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
            elif tr.lower() == "tcp":
                TCP += 1
            obfs = params['obfs']
            if len(obfs) != 1:
                print("wrong obfs:", i)
                sys.exit(1)
            obfs = obfs[0]
            if obfs.lower() == "obfs4":
                OBFS4 += 1

    print("INPUTS:\t", INPUTS)
    print("PROTO:\t", ','.join([x for x in set(PROTO)]))
    print("PRVDR:\t", ','.join([x for x in set(PROVIDERS)]))
    print("UDP:\t", UDP)
    print("TCP:\t", TCP)
    print("OBFS4:\t", OBFS4)
    print("ADDRS:")
    for addr in sorted(list(set(ADDRS))):
        print(f"\t{addr}")


if __name__ == "__main__":
    if len(sys.argv) == 2 and os.path.exists(path := sys.argv[1]):
        with open(path, 'r') as f:
            j = json.loads(f.read())
            check_inputs(j)
