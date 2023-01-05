#!/usr/bin/env python3
import json
import os
import sys

EP=os.getenv('ENDPOINTS').split(',')
d = {'ip{:02}'.format(i+1): e for (i, e) in enumerate(EP)}
j = json.load(open(sys.argv[1]))
inputs = j['nettests'][0]['inputs']
for i, tmpl in enumerate(inputs):
    new = tmpl.format(**d)
    inputs[i] = new
print(json.dumps(j))
