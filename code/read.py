#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import json
import pandas as pd

with open('/Users/tete/628data/business_train.json', 'r') as f:
    bus_train = f.readlines()
    for i in range(len(bus_train)):
        bus_train[i] = json.loads(bus_train[i])
f.close

with open('/Users/tete/628data/review_train.json', 'r') as f:
    review_train = f.readlines()
    for i in range(10):
        review_train[i] = json.loads(review_train[i])
f.close

for i in range(len(bus_train)):
    if bus_train[i]['categories'] and 'Restaurant' not in bus_train[i]['categories'] and 'Food' not in bus_train[i]['categories']:
        print(bus_train[i]['categories'])
        
#---------

for x in bus_train[:]:
    if x['categories'] and 'Restaurant' not in x['categories'] and 'Food' not in x['categories']:
        bus_train.remove(x)
print(len(bus_train))

for i in range(len(bus_train)):
    if bus_train[i]['categories']:
        bus_train[i]['categories'] = bus_train[i]['categories'].replace(' & ', ', ')

bus_json = []
for i in range(len(bus_train)):
        bus_json.append(json.dumps(bus_train[i]))
for i in range(len(bus_json)):
    open('/Users/tete/628data/bus_food.json','a').write(bus_json[i])
    open('/Users/tete/628data/bus_food.json','a').write('\n')


#----------------------------------------------
        
cat = set()
for i in range(len(bus_train)):
    if bus_train[i]['categories']:
        cat = set(bus_train[i]['categories'].split(', ')) | cat
print(len(cat))

att = set()
for i in range(len(bus_train)):
    if bus_train[i]['attributes']:
        att = set(list(bus_train[i]['attributes'])) | att
print(len(att))


aaa = pd.read_json('/Users/tete/628data/bus_food.json',orient = 'records',lines = True)


with open('/Users/tete/628data/bus_food.json', 'r') as f:
    aaa = f.readlines()
    for i in range(len(aaa)):
        aaa[i] = json.loads(aaa[i])
f.close
