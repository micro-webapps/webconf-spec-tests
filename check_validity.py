from jsonschema import validate
import json
import sys
import os

f = open("schema.json", "r")
schema = json.load(f)
f.close()

tests = os.listdir(".")
tests.sort()
for d in tests:
    if not os.path.isdir(d) or len(d) != 3:
        continue
    
    for cfg in os.listdir(d):
        if not cfg.endswith(".json"):
            continue
        print d + "/" + cfg
        f = open(d + "/" + cfg, "r")
        data = json.load(f)
        f.close()

        validate(data, schema)
