#coding:utf-8
#!/usr/bin/python
# Filename: map.py
hits = {"home": 125, "sitemap": 27, "about": 43}

hits["radish"] = 2

keys = hits.keys()
values = hits.values()

print("Keys:")
print(keys)
print(len(keys))

print("Values:")
print(values)
print(len(values))

time=set()
time.add