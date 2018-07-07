#!/usr/bin/python3

import re

from math import radians, sin, cos, sqrt, asin
 

def haversine(x1, y1, x2, y2):
    lat1 = y1
    lon1 = x1
    lat2 = y2
    lon2 = x2
 
    R = 6372.8 * 1000
    
    dLat = radians(lat2 - lat1)
    dLon = radians(lon2 - lon1)
    lat1 = radians(lat1)
    lat2 = radians(lat2)
    
    a = sin(dLat/2)**2 + cos(lat1)*cos(lat2)*sin(dLon/2)**2
    c = 2*asin(sqrt(a))
    
    return R * c


with open("track.gpx") as f:
    data = f.readlines()
    
points = []
MIN_DISTANCE = 10
count = 0
for line in data:
    m = re.search('<trkpt lat="([0-9.]+)" lon="([0-9.]+)">', line)
    if not m:
        continue
    count += 1
    y = float(m.group(1))
    x = float(m.group(2))
    ok = True
    for point in points[::-1]:
        if haversine(x, y, *point) < MIN_DISTANCE:
            ok = False
    if ok:
        points.append((x, y))
        
print("[")
for point in points:
    print("[{}, {}],".format(*point))
print("]")
